import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shortes/features/main_page/domain/entities/user_note.dart';
import 'package:shortes/features/main_page/domain/usecases/get_user_notes_usecase.dart';

part 'main_page_state.dart';
part 'main_page_cubit.freezed.dart';

@injectable
class MainPageCubit extends Cubit<MainPageState> {
  final GetUserNotesUseCase getUserNotesUseCase;
  MainPageCubit({
    required this.getUserNotesUseCase,
}) : super(const MainPageState.initial());

  Future<void> initMainPage({required GetStorage getStorage}) async{
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

}
