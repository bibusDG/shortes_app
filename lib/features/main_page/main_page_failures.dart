import 'package:shortes/core/failure/failure.dart';

class GetUserNotesFailure extends Failure{
  const GetUserNotesFailure({required super.failureMessage});
}

class AddNEwNoteFailure extends Failure{
  const AddNEwNoteFailure({required super.failureMessage});
}

class DeleteNoteFailure extends Failure{
  const DeleteNoteFailure({required super.failureMessage});
}

class AddNoteToCalendarFailure extends Failure{
  const AddNoteToCalendarFailure({required super.failureMessage});
}