part of 'main_page_cubit.dart';

@freezed
class MainPageState with _$MainPageState {
  const factory MainPageState.initial() = _Initial;
  const factory MainPageState.lackOfNotes({required String message}) = _LackOfNotes;
  const factory MainPageState.notes({required List<dynamic> userNotes}) = _Notes;
  const factory MainPageState.creatingNote() = _CreatingNote;
  const factory MainPageState.creatingNoteSuccess() = _CreatingNoteSuccess;
  const factory MainPageState.creatingNoteFailure() = _CreatingNoteFailure;
  const factory MainPageState.removingNote() = _RemovingNote;
  const factory MainPageState.noteRemovedSuccess() = _NoteRemovedSuccess;
  const factory MainPageState.noteRemovedFailure() = _NoteRemovedFailure;
  const factory MainPageState.addingToCalendar() = _AddingToCalendar;
  const factory MainPageState.addToCalendarFailure() = _AddToCalendarFailure;
  const factory MainPageState.addToCalendarSuccess() = _AddToCalendarSuccess;
}
