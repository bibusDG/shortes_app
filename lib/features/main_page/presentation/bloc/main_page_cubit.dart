import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shortes/features/main_page/domain/entities/user_note.dart';
import 'package:shortes/features/main_page/domain/usecases/add_new_note_usecase.dart';
import 'package:shortes/features/main_page/domain/usecases/delete_note_usecase.dart';
import 'package:shortes/features/main_page/domain/usecases/get_user_notes_usecase.dart';

part 'main_page_state.dart';
part 'main_page_cubit.freezed.dart';

@injectable
class MainPageCubit extends Cubit<MainPageState> {
  final GetUserNotesUseCase getUserNotesUseCase;
  final AddNewNoteUseCase addNewNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  MainPageCubit({
    required this.getUserNotesUseCase,
    required this.addNewNoteUseCase,
    required this.deleteNoteUseCase,
}) : super(const MainPageState.initial());

  Future<void> initMainPage({required GetStorage getStorage}) async{
    emit(MainPageState.creatingNote());
    final result = await getUserNotesUseCase(GetUserNotesParams(getStorage: getStorage));
    result.fold((failure){
      print('failure');
    }, (success){
      if(success.isEmpty){
        emit(MainPageState.lackOfNotes(message: 'Press + icon to add note via voice or '
            'tap twice + icon to add written note.'));
      }else{
        emit(MainPageState.notes(userNotes: success));
      }
    });
  }

  Future<void> addNewNote({
    required GetStorage getStorage,
    required String noteTitle,
    required String noteContent
}) async{
    final result = await addNewNoteUseCase(
        AddNoteParams(
            getStorage: getStorage,
            movedToCalendar: false,
            haveReminder: false,
            creationDate: DateTime.now().toString().substring(0,16),
            noteContent: noteContent,
            noteName: noteTitle,
            reminderDate: DateTime.now()));
    result.fold((failure){
      emit(MainPageState.creatingNoteFailure());
    }, (success){
      emit(MainPageState.creatingNoteSuccess());
    });
  }

  Future<void> removeNote({required GetStorage getStorage, required int index}) async{
    emit(MainPageState.removingNote());
    final result = await deleteNoteUseCase(DeleteNoteParams(getStorage: getStorage, index: index));
    result.fold((failure){
      emit(MainPageState.noteRemovedFailure());
    }, (success){
      emit(MainPageState.noteRemovedSuccess());
    });
  }

}
