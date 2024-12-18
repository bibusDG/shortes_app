part of 'main_page_cubit.dart';

@freezed
class MainPageState with _$MainPageState {
  const factory MainPageState.initial() = _Initial;
  const factory MainPageState.lackOfNotes({required String message}) = _LackOfNotes;
  const factory MainPageState.notes({required List<dynamic> userNotes}) = _Notes;
}
