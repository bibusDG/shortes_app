// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserNote _$UserNoteFromJson(Map<String, dynamic> json) {
  return _UserNote.fromJson(json);
}

/// @nodoc
mixin _$UserNote {
  String get noteName => throw _privateConstructorUsedError;
  String get noteContent => throw _privateConstructorUsedError;
  String get creationDate => throw _privateConstructorUsedError;
  bool get movedToCalendar => throw _privateConstructorUsedError;
  bool get haveReminder => throw _privateConstructorUsedError;
  DateTime get reminderDate => throw _privateConstructorUsedError;

  /// Serializes this UserNote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserNoteCopyWith<UserNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNoteCopyWith<$Res> {
  factory $UserNoteCopyWith(UserNote value, $Res Function(UserNote) then) =
      _$UserNoteCopyWithImpl<$Res, UserNote>;
  @useResult
  $Res call(
      {String noteName,
      String noteContent,
      String creationDate,
      bool movedToCalendar,
      bool haveReminder,
      DateTime reminderDate});
}

/// @nodoc
class _$UserNoteCopyWithImpl<$Res, $Val extends UserNote>
    implements $UserNoteCopyWith<$Res> {
  _$UserNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? noteName = null,
    Object? noteContent = null,
    Object? creationDate = null,
    Object? movedToCalendar = null,
    Object? haveReminder = null,
    Object? reminderDate = null,
  }) {
    return _then(_value.copyWith(
      noteName: null == noteName
          ? _value.noteName
          : noteName // ignore: cast_nullable_to_non_nullable
              as String,
      noteContent: null == noteContent
          ? _value.noteContent
          : noteContent // ignore: cast_nullable_to_non_nullable
              as String,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as String,
      movedToCalendar: null == movedToCalendar
          ? _value.movedToCalendar
          : movedToCalendar // ignore: cast_nullable_to_non_nullable
              as bool,
      haveReminder: null == haveReminder
          ? _value.haveReminder
          : haveReminder // ignore: cast_nullable_to_non_nullable
              as bool,
      reminderDate: null == reminderDate
          ? _value.reminderDate
          : reminderDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserNoteImplCopyWith<$Res>
    implements $UserNoteCopyWith<$Res> {
  factory _$$UserNoteImplCopyWith(
          _$UserNoteImpl value, $Res Function(_$UserNoteImpl) then) =
      __$$UserNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String noteName,
      String noteContent,
      String creationDate,
      bool movedToCalendar,
      bool haveReminder,
      DateTime reminderDate});
}

/// @nodoc
class __$$UserNoteImplCopyWithImpl<$Res>
    extends _$UserNoteCopyWithImpl<$Res, _$UserNoteImpl>
    implements _$$UserNoteImplCopyWith<$Res> {
  __$$UserNoteImplCopyWithImpl(
      _$UserNoteImpl _value, $Res Function(_$UserNoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? noteName = null,
    Object? noteContent = null,
    Object? creationDate = null,
    Object? movedToCalendar = null,
    Object? haveReminder = null,
    Object? reminderDate = null,
  }) {
    return _then(_$UserNoteImpl(
      noteName: null == noteName
          ? _value.noteName
          : noteName // ignore: cast_nullable_to_non_nullable
              as String,
      noteContent: null == noteContent
          ? _value.noteContent
          : noteContent // ignore: cast_nullable_to_non_nullable
              as String,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as String,
      movedToCalendar: null == movedToCalendar
          ? _value.movedToCalendar
          : movedToCalendar // ignore: cast_nullable_to_non_nullable
              as bool,
      haveReminder: null == haveReminder
          ? _value.haveReminder
          : haveReminder // ignore: cast_nullable_to_non_nullable
              as bool,
      reminderDate: null == reminderDate
          ? _value.reminderDate
          : reminderDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserNoteImpl implements _UserNote {
  const _$UserNoteImpl(
      {required this.noteName,
      required this.noteContent,
      required this.creationDate,
      required this.movedToCalendar,
      required this.haveReminder,
      required this.reminderDate});

  factory _$UserNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserNoteImplFromJson(json);

  @override
  final String noteName;
  @override
  final String noteContent;
  @override
  final String creationDate;
  @override
  final bool movedToCalendar;
  @override
  final bool haveReminder;
  @override
  final DateTime reminderDate;

  @override
  String toString() {
    return 'UserNote(noteName: $noteName, noteContent: $noteContent, creationDate: $creationDate, movedToCalendar: $movedToCalendar, haveReminder: $haveReminder, reminderDate: $reminderDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserNoteImpl &&
            (identical(other.noteName, noteName) ||
                other.noteName == noteName) &&
            (identical(other.noteContent, noteContent) ||
                other.noteContent == noteContent) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.movedToCalendar, movedToCalendar) ||
                other.movedToCalendar == movedToCalendar) &&
            (identical(other.haveReminder, haveReminder) ||
                other.haveReminder == haveReminder) &&
            (identical(other.reminderDate, reminderDate) ||
                other.reminderDate == reminderDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, noteName, noteContent,
      creationDate, movedToCalendar, haveReminder, reminderDate);

  /// Create a copy of UserNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserNoteImplCopyWith<_$UserNoteImpl> get copyWith =>
      __$$UserNoteImplCopyWithImpl<_$UserNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserNoteImplToJson(
      this,
    );
  }
}

abstract class _UserNote implements UserNote {
  const factory _UserNote(
      {required final String noteName,
      required final String noteContent,
      required final String creationDate,
      required final bool movedToCalendar,
      required final bool haveReminder,
      required final DateTime reminderDate}) = _$UserNoteImpl;

  factory _UserNote.fromJson(Map<String, dynamic> json) =
      _$UserNoteImpl.fromJson;

  @override
  String get noteName;
  @override
  String get noteContent;
  @override
  String get creationDate;
  @override
  bool get movedToCalendar;
  @override
  bool get haveReminder;
  @override
  DateTime get reminderDate;

  /// Create a copy of UserNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserNoteImplCopyWith<_$UserNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
