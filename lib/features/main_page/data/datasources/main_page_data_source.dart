import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shortes/features/main_page/domain/entities/user_note.dart';

abstract class MainPageDataSource{
  const MainPageDataSource();

  Future<List<dynamic>> getUserNotes({
    required GetStorage getStorage,
});

  Future<void> addNewNote({
    required GetStorage getStorage,
    required String noteName,
    required String noteContent,
    required String creationDate,
    required bool movedToCalendar,
    required bool haveReminder,
    required DateTime reminderDate,
  });

  Future<void> deleteNote({
    required GetStorage getStorage,
    required int index,
  });

}
@Singleton(as: MainPageDataSource)
class MainPageDataSourceImp implements MainPageDataSource{
  @override
  Future<List<dynamic>> getUserNotes({required GetStorage getStorage}) async{
    final List<dynamic> userNotes = getStorage.read('listOfNotes');
    return userNotes;
  }

  @override
  Future<void> addNewNote({
    required GetStorage getStorage,
    required String noteName,
    required String noteContent,
    required String creationDate,
    required bool movedToCalendar,
    required bool haveReminder,
    required DateTime reminderDate}) async{
    final List<dynamic> listOfNotes = await getStorage.read('listOfNotes');
    listOfNotes.insert(0,
      UserNote(
          noteName: noteName,
          noteContent: noteContent,
          creationDate: creationDate,
          movedToCalendar: movedToCalendar,
          haveReminder: haveReminder,
          reminderDate: reminderDate).toJson(),
    );
    getStorage.write('listOfNotes', listOfNotes);
  }

  @override
  Future<void> deleteNote({required GetStorage getStorage, required int index}) async{
    final List<dynamic> listOfNotes = await getStorage.read('listOfNotes');
    listOfNotes.removeAt(index);
    getStorage.write('listOfNotes', listOfNotes);
  }
}