import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_note.freezed.dart';
part 'user_note.g.dart';

@freezed
class UserNote with _$UserNote{
  const factory UserNote({
    required String noteName,
    required String noteContent,
    required String creationDate,
    required bool movedToCalendar,
    required bool haveReminder,
    required DateTime reminderDate,
}) = _UserNote;
  factory UserNote.fromJson(Map<String, dynamic>? json) => _$UserNoteFromJson(json!);
}