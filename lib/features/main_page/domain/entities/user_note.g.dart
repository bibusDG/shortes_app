// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserNoteImpl _$$UserNoteImplFromJson(Map<String, dynamic> json) =>
    _$UserNoteImpl(
      noteName: json['noteName'] as String,
      noteContent: json['noteContent'] as String,
      creationDate: json['creationDate'] as String,
      movedToCalendar: json['movedToCalendar'] as bool,
      haveReminder: json['haveReminder'] as bool,
      reminderDate: DateTime.parse(json['reminderDate'] as String),
    );

Map<String, dynamic> _$$UserNoteImplToJson(_$UserNoteImpl instance) =>
    <String, dynamic>{
      'noteName': instance.noteName,
      'noteContent': instance.noteContent,
      'creationDate': instance.creationDate,
      'movedToCalendar': instance.movedToCalendar,
      'haveReminder': instance.haveReminder,
      'reminderDate': instance.reminderDate.toIso8601String(),
    };
