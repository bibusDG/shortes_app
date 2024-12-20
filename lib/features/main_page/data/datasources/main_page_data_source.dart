import 'package:add_2_calendar/add_2_calendar.dart';
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

  Future<Event> addNoteToCalendar({
    required String noteTitle,
    required String noteContent,
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

  @override
  Future<Event> addNoteToCalendar({required String noteTitle, required String noteContent}) async{
    final Event event = Event(
      title: noteTitle,
      description: noteContent,
      location: 'Event location',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      iosParams: IOSParams(
        reminder: Duration(/* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
        // url: 'https://www.example.com', // on iOS, you can set url to your event.
      ),
      androidParams: AndroidParams(
        emailInvites: [], // on Android, you can add invite emails to your event.
      ),
    );
    return event;
    // await Add2Calendar.addEvent2Cal(event);
  }
}