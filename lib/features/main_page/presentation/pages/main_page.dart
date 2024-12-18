import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:shortes/features/main_page/domain/entities/user_note.dart';
import 'package:shortes/features/main_page/presentation/bloc/main_page_cubit.dart';

class MainPage extends HookWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    final textNoteTitle = useTextEditingController();
    final textNoteContent = useTextEditingController();

    final userData = GetStorage();
    // final List<dynamic> list = userData.read('listOfNotes');
    // print(list);
    // list.add(UserNote(noteName: 'noteName', noteContent: 'noteContent', creationDate: 'creationDate', movedToCalendar: false, haveReminder: false, reminderDate: DateTime.now()).toJson(),);
    // print(list);
    // userData.write('listOfNotes', list);
    // userData.write('listOfNotes', [
    //   UserNote(noteName: 'noteName', noteContent: 'noteContent', creationDate: 'creationDate', movedToCalendar: false, haveReminder: false, reminderDate: DateTime.now()),
    //   UserNote(noteName: 'moja notka', noteContent: 'noteContent', creationDate: 'creationDate', movedToCalendar: false, haveReminder: false, reminderDate: DateTime.now())
    // ]);
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
        onLongPressStart: (test){
            print('start');
          },
        onLongPressEnd: (test){
            print('end');
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
        lackOfNotes: (message) => Center(child: SizedBox(
          width: 250,
            child: Text(message, textAlign: TextAlign.justify,)),),
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
                  endActionPane: const ActionPane(
                    motion: StretchMotion(),
                    children: [
                      CustomSlidableAction(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        // An action can be bigger than the others.
                        flex: 1,
                        onPressed: null,
                        backgroundColor: Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        child: Icon(Icons.calendar_month, size: 40,),

                        // label: 'Add to calendar',
                      ),
                      CustomSlidableAction(
                        flex: 1,
                        onPressed: null,
                        backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        child: Icon(Icons.notification_add, size: 40,),
                        // label: 'Add notification',
                      ),
                      CustomSlidableAction(
                        // An action can be bigger than the others.
                        flex: 1,
                        onPressed: null,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.delete_forever, size: 40,),

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
                                      Text(userNote.noteName, style: TextStyle(fontSize: 30),),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(userNote.creationDate),
                                          Row(
                                            children: [
                                              Icon(Icons.circle,
                                                color: userNote.haveReminder == false? Colors.blue : Colors.transparent,),
                                              Icon(Icons.circle,
                                                color: userNote.movedToCalendar == false? Colors.green : Colors.transparent,
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
                              child: Center(child: Text(userNote.noteContent)))
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
      return AlertDialog(
        title: const Center(child: Text('Create Shorte'),),
        content: SizedBox(
          height: 450,
          width: 300,
          child: Column(
            children: [
              TextField(
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
                height: 300,
                child: TextField(
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
              SizedBox(
                height: 10,
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
                      }else if(contentController.text.isNotEmpty && titleController.text.isEmpty){
                        final newNoteTitle = contentController.text.trim().split(' ').take(2).join(' ');
                        context.pop();
                        await mainPageCubit.addNewNote(
                            getStorage: getStorage,
                            noteTitle: newNoteTitle,
                            noteContent: contentController.text.trim());
                      }else if(contentController.text.isEmpty && titleController.text.isNotEmpty){
                        context.pop();
                        await mainPageCubit.addNewNote(
                            getStorage: getStorage,
                            noteTitle: titleController.text.trim(),
                            noteContent: '');
                      }else{
                        print('not possible to save');
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
      );
    });
  }
}
