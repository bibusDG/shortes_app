import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shortes/features/main_page/domain/entities/user_note.dart';

abstract class MainPageDataSource{
  const MainPageDataSource();

  Future<List<dynamic>> getUserNotes({
    required GetStorage getStorage,
});

}
@Singleton(as: MainPageDataSource)
class MainPageDataSourceImp implements MainPageDataSource{
  @override
  Future<List<dynamic>> getUserNotes({required GetStorage getStorage}) async{
    final List<dynamic> userNotes = getStorage.read('listOfNotes');
    return userNotes;
  }
}