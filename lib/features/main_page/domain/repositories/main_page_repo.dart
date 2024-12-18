import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shortes/features/main_page/domain/entities/user_note.dart';

import '../../../../core/failure/failure.dart';

abstract class MainPageRepo{
  const MainPageRepo();

  Future<Either<Failure, List<dynamic>>> getUserNotes({
    required GetStorage getStorage,
});

  Future<Either<Failure,void>> addNewNote({
    required GetStorage getStorage,
    required String noteName,
    required String noteContent,
    required String creationDate,
    required bool movedToCalendar,
    required bool haveReminder,
    required DateTime reminderDate,
});
}