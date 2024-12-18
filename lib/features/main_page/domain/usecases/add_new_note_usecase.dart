import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shortes/core/failure/failure.dart';
import 'package:shortes/core/usecases/usecases.dart';
import 'package:shortes/features/main_page/domain/repositories/main_page_repo.dart';

@injectable
class AddNewNoteUseCase implements UseCaseWithParams<void, AddNoteParams>{
  final MainPageRepo repo;
  const AddNewNoteUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(params) async{
    return await repo.addNewNote(
        getStorage: params.getStorage,
        noteName: params.noteName,
        noteContent: params.noteContent,
        creationDate: params.creationDate,
        movedToCalendar: params.movedToCalendar,
        haveReminder: params.haveReminder,
        reminderDate: params.reminderDate);
  }
}

class AddNoteParams extends Equatable{
  final GetStorage getStorage;
  final String noteName;
  final String noteContent;
  final String creationDate;
  final bool movedToCalendar;
  final bool haveReminder;
  final DateTime reminderDate;
  const AddNoteParams({
    required this.getStorage,
    required this.movedToCalendar,
    required this.haveReminder,
    required this.creationDate,
    required this.noteContent,
    required this.noteName,
    required this.reminderDate
});

  @override
  List<Object> get props => [getStorage, noteName, noteContent];

}