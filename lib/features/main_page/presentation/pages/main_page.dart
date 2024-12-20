import 'dart:io';
import 'dart:math';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:shortes/features/main_page/domain/entities/user_note.dart';
import 'package:shortes/features/main_page/presentation/bloc/main_page_cubit.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MainPage extends HookWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    final SpeechToText _speechToText = SpeechToText();
    final _lastWords = useState('');
    final _speechEnabled = useState(false);
    final String localLanguage = Platform.localeName;
    // final random = Random();
    // print(random.nextInt(99999999));
    print(localLanguage);

    final textNoteTitle = useTextEditingController();
    final textNoteContent = useTextEditingController();
    final voiceTextController = useTextEditingController();

    SpeechFunctions(
      voiceTextController: voiceTextController,
      speechEnabled: _speechEnabled,
      speechToText: _speechToText,
      lastWords: _lastWords,
    ).initSpeech();

    final userData = GetStorage();
    final _mainPageCubit = useBloc<MainPageCubit>();
    final _mainPageState = useBlocBuilder(_mainPageCubit);

    useEffect((){
      _mainPageCubit.initMainPage(getStorage: userData);
      return null;
    },
      [_mainPageCubit],
    );

    useBlocListener<MainPageCubit, MainPageState>(_mainPageCubit, (bloc, current, context){
      current.whenOrNull(
        creatingNoteFailure: () async{
          await Future.delayed((Duration(seconds: 3)));
          _mainPageCubit.initMainPage(getStorage: userData);
        },
        creatingNoteSuccess: () async{
          await Future.delayed((Duration(seconds: 3)));
          _mainPageCubit.initMainPage(getStorage: userData);
        },
        noteRemovedFailure: () async{
          await Future.delayed((Duration(seconds: 3)));
          _mainPageCubit.initMainPage(getStorage: userData);
        },
        noteRemovedSuccess: () async{
          await Future.delayed((Duration(seconds: 3)));
          _mainPageCubit.initMainPage(getStorage: userData);
        },
        addToCalendarFailure: () async{
          await Future.delayed((Duration(seconds: 3)));
          _mainPageCubit.initMainPage(getStorage: userData);
        },
        addToCalendarSuccess: () async{
          await Future.delayed((Duration(seconds: 5)));
          _mainPageCubit.initMainPage(getStorage: userData);
        }
      );
    });

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: (){
          createStandardNote(
              context: context,
              titleController: textNoteTitle,
              contentController: textNoteContent,
              mainPageCubit: _mainPageCubit,
              getStorage: userData,
          );
        },
        onLongPress: () async{
            if(_speechEnabled.value == true) {
              voiceTextController.clear();
              await createVoiceNote(
                  context: context,
                  voiceTextController: voiceTextController,
                  speechToText: _speechToText,
                  speechEnabled: _speechEnabled,
                  lastWords: _lastWords,
                  mainPageCubit: _mainPageCubit,
                  getStorage: userData,
                  localLanguage: localLanguage,
              );
              // SpeechFunctions(
              //   voiceTextController: voiceTextController,
              //   speechEnabled: _speechEnabled,
              //   speechToText: _speechToText,
              //   lastWords: _lastWords,
              // ).startListening();
            }else{
              SpeechFunctions(
                voiceTextController: voiceTextController,
                speechEnabled: _speechEnabled,
                speechToText: _speechToText,
                lastWords: _lastWords,
              ).initSpeech();
            }
          },
          child: Icon(Icons.add_circle, size: 100,)),
      appBar: _mainPageState.whenOrNull(
        lackOfNotes: null,
        notes:(userNotes) => AppBar(
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset('assets/images/shortes.png'),
          ),
          centerTitle: true,
          actions: [
            Icon(Icons.language)
          ],
          backgroundColor: Colors.transparent,
        ),
      ),
      body: _mainPageState.whenOrNull(
        lackOfNotes: (message) => Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/shortes_big.png', scale: 1.8,),
            SizedBox(
              width: 250,
                child: Text(message, textAlign: TextAlign.center,)),
          ],
        ),),
        notes: (userNotes) {
          return ListView.builder(
            itemCount: userNotes.length,
              itemBuilder: (BuildContext context, int index){
              final UserNote userNote = UserNote.fromJson(userNotes[index]);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Slidable(
                  key: const ValueKey(0),
                  closeOnScroll: true,
                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      CustomSlidableAction(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        // An action can be bigger than the others.
                        flex: 1,
                        onPressed: (context) async{
                         await _mainPageCubit.addNoteToCalendar(
                              getStorage: userData,
                              index: index,
                              noteTitle: 'Shorty note : ${userNote.noteName}',
                              noteContent: userNote.noteContent);
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.calendar_month, size: 40,),

                        // label: 'Add to calendar',
                      ),
                      // const CustomSlidableAction(
                      //   flex: 1,
                      //   onPressed: null,
                      //   backgroundColor: Color(0xFF0392CF),
                      //   foregroundColor: Colors.white,
                      //   child: Icon(Icons.notification_add, size: 40,),
                      //   // label: 'Add notification',
                      // ),
                      CustomSlidableAction(
                        // An action can be bigger than the others.
                        flex: 1,
                        onPressed: (context) async{
                          await _mainPageCubit.removeNote(getStorage: userData, index: index);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: const Icon(Icons.delete_forever, size: 40,),

                        // label: 'Add to calendar',
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Card(
                      color: Colors.white24,
                      child: ExpansionTile(
                        showTrailingIcon: false,
                          enabled: userNote.noteContent.trim() == ''? false : true,
                          shape: const Border(),
                          title:
                              SizedBox(
                                height: 90,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 250,
                                          child: Text(userNote.noteName, style: TextStyle(fontSize: 50, fontFamily: 'Amatic', fontWeight: FontWeight.w100),overflow: TextOverflow.ellipsis,)),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(userNote.creationDate),
                                          Row(
                                            children: [
                                              Icon(Icons.circle,
                                                color: userNote.haveReminder == true? Colors.blue : Colors.transparent,),
                                              Icon(Icons.circle,
                                                color: userNote.movedToCalendar == true? Colors.green : Colors.transparent,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),),

                        children: [
                          SizedBox(
                            height: 200,
                              child: Center(child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: SingleChildScrollView(
                                    child: Text(userNote.noteContent, textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Amatic', fontSize: 25, fontWeight: FontWeight.bold),)),
                              )))
                        ]),
                    ),
                  ),
                ),
              );

          });
        },
        creatingNote: () => Center(child: CircularProgressIndicator(),),
        creatingNoteFailure: () => Center(child: Text('Not possible to create new note.'),),
        creatingNoteSuccess: () => Center(child: Text('New note created'),),
        noteRemovedFailure: () => Center(child: Text('Note remove failure'),),
        noteRemovedSuccess: () => Center(child: Text('Note removed'),),
        removingNote: () => Center(child: CircularProgressIndicator()),
        addingToCalendar: () => Center(child: CircularProgressIndicator(),),
        addToCalendarSuccess: () => Center(child: Text('Note added to calendar'),),
        addToCalendarFailure: () => Center(child: Text('Unable to add note to calendar'),)
      ),
    );
  }

  void createStandardNote({
    required BuildContext context,
    required TextEditingController titleController,
    required TextEditingController contentController,
    required MainPageCubit mainPageCubit,
    required GetStorage getStorage,
  }){
    showDialog(
      barrierDismissible: false,
        context: context, builder: (BuildContext context){
      return GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: AlertDialog(
          title: const Center(child: Text('Create Shorte', style: TextStyle(fontFamily: 'Amatic', fontSize: 40, fontWeight: FontWeight.bold)),),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 350,
              width: 300,
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(fontFamily: 'Amatic', fontSize: 20, fontWeight: FontWeight.bold),
                    controller: titleController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.black, width: 3.5),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.black, width: 1.5),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'Note name',
                  ),),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 200,
                    child: TextField(
                      style: TextStyle(fontFamily: 'Amatic', fontSize: 20, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 10,
                      controller: contentController,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.black, width: 3.5),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.black, width: 1.5),
                        ),
                        border: const OutlineInputBorder(),
                        hintText: 'Content',
                      ),),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () async{
                          if(contentController.text.isNotEmpty && titleController.text.isNotEmpty){
                            context.pop();
                            await mainPageCubit.addNewNote(
                                getStorage: getStorage,
                                noteTitle: titleController.text.trim(),
                                noteContent: contentController.text.trim());
                            contentController.clear();
                            titleController.clear();
                          }else if(contentController.text.isNotEmpty && titleController.text.isEmpty){
                            final newNoteTitle = contentController.text.trim().split(' ').take(2).join(' ');
                            context.pop();
                            await mainPageCubit.addNewNote(
                                getStorage: getStorage,
                                noteTitle: newNoteTitle,
                                noteContent: contentController.text.trim());
                            contentController.clear();
                            titleController.clear();
                          }else if(contentController.text.isEmpty && titleController.text.isNotEmpty){
                            context.pop();
                            await mainPageCubit.addNewNote(
                                getStorage: getStorage,
                                noteTitle: titleController.text.trim(),
                                noteContent: '');
                            contentController.clear();
                            titleController.clear();
                          }else{
                            context.pop();
                          }

                        },
                        icon: Icon(Icons.check_circle, size: 45, color: Colors.green,),),
                      IconButton(
                        onPressed: (){
                          context.pop();
                          contentController.clear();
                          titleController.clear();
                        },
                        icon: Icon(Icons.cancel, size: 45, color: Colors.red,))
                    ]

                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> createVoiceNote({
    required BuildContext context,
    required TextEditingController voiceTextController,
    required SpeechToText speechToText,
    required ValueNotifier lastWords,
    required ValueNotifier speechEnabled,
    required MainPageCubit mainPageCubit,
    required GetStorage getStorage,
    required String localLanguage,
})async {
    await SpeechFunctions(
      voiceTextController: voiceTextController,
      speechEnabled: speechEnabled,
      speechToText: speechToText,
      lastWords: lastWords,
    ).startListening(localeLanguage: localLanguage);
    if(context.mounted){
      showDialog(context: context, builder: (BuildContext context){
        return ValueListenableBuilder(
          valueListenable: lastWords,
          builder: (context, value, child){
            return AlertDialog(
              title: const Center(child: Text('Create Shorte',
                style: TextStyle(fontFamily: 'Amatic', fontSize: 30, fontWeight: FontWeight.bold),
              ),),
              content: SizedBox(
                height: 350,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: 300,
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Text(value, textAlign: TextAlign.justify,style: TextStyle(fontFamily: 'Amatic', fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    IconButton(onPressed: () async{
                      if(lastWords.value.trim().isEmpty){
                        if(context.mounted){
                          context.pop();
                        }
                      }else{
                        if(context.mounted){
                          context.pop();
                        }
                        await mainPageCubit.addNewNote(
                            getStorage: getStorage,
                            noteTitle: lastWords.value.trim().split(' ').take(2).join(' '),
                            noteContent: lastWords.value.trim());
                      }
                      await SpeechFunctions(
                          speechToText: speechToText,
                          speechEnabled: speechEnabled,
                          lastWords: lastWords,
                          voiceTextController: voiceTextController
                      ).stopListening();
                    }, icon: Icon(Icons.stop_circle, size: 60, color: Colors.red,)),

                  ],
                ),
              ),
            );
          },
        );
      }).then((value) {
        SpeechFunctions(
          voiceTextController: voiceTextController,
          speechEnabled: speechEnabled,
          speechToText: speechToText,
          lastWords: lastWords,
        ).stopListening();
      });
    }
  }

}

class SpeechFunctions {
  final ValueNotifier lastWords;
  final SpeechToText speechToText;
  final ValueNotifier speechEnabled;
  final TextEditingController voiceTextController;
  const SpeechFunctions({
    required this.speechToText,
    required this.lastWords,
    required this.speechEnabled,
    required this.voiceTextController,
});

  void initSpeech() async{
    speechEnabled.value = await speechToText.initialize();
    // print(speechEnabled.value);
  }

  Future<void> startListening({required String localeLanguage}) async{
    lastWords.value = '';
    await speechToText.listen(
        localeId: localeLanguage,
        onResult: _onSpeechResult);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    lastWords.value = result.recognizedWords;
    // voiceTextController.text = result.recognizedWords;
  }

  Future<void> stopListening() async{
    print('stopped');
    lastWords.value = '';
    await speechToText.stop();
  }

}