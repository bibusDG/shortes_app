import 'package:dartz/dartz.dart';
import 'package:get_storage/src/storage_impl.dart';
import 'package:injectable/injectable.dart';
import 'package:shortes/core/failure/failure.dart';
import 'package:shortes/features/main_page/data/datasources/main_page_data_source.dart';
import 'package:shortes/features/main_page/domain/entities/user_note.dart';
import 'package:shortes/features/main_page/domain/repositories/main_page_repo.dart';
import 'package:shortes/features/main_page/main_page_failures.dart';

@Singleton(as: MainPageRepo)
class MainPageRepoImp implements MainPageRepo{
  final MainPageDataSource dataSource;
  const MainPageRepoImp({required this.dataSource});

  @override
  Future<Either<Failure, List<dynamic>>> getUserNotes({required GetStorage getStorage}) async{
    try{
      final result = await dataSource.getUserNotes(getStorage: getStorage);
      return Right(result);
    }catch(error){
      return const Left(GetUserNotesFailure(failureMessage: 'Unable to get user notes'));
    }
  }

  @override
  Future<Either<Failure, void>> addNewNote({
    required GetStorage getStorage,
    required String noteName,
    required String noteContent,
    required String creationDate,
    required bool movedToCalendar,
    required bool haveReminder,
    required DateTime reminderDate}) async{
    try{
      final result = await dataSource.addNewNote(
          getStorage: getStorage,
          noteName: noteName,
          noteContent: noteContent,
          creationDate: creationDate,
          movedToCalendar: movedToCalendar,
          haveReminder: haveReminder,
          reminderDate: reminderDate);
      return Right(result);
    }catch(error){
      return const Left(AddNEwNoteFailure(failureMessage: 'Unable to add new note'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote({required GetStorage getStorage, required int index}) async{
    try{
      final result = await dataSource.deleteNote(getStorage: getStorage, index: index);
      return Right(result);
    }catch(error){
      return const Left(DeleteNoteFailure(failureMessage: 'Unable to delete note'));
    }
  }

  @override
  Future<Either<Failure, void>> addNoteToCalendar({
    required String noteTitle,
    required String noteContent}) async{
    try{
      final result = dataSource.addNoteToCalendar(noteTitle: noteTitle, noteContent: noteContent);
      return Right(result);
    }catch(error){
      return const Left(AddNoteToCalendarFailure(failureMessage: 'Unable to add note to calendar'));
    }
  }
}