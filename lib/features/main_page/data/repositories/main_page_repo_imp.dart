import 'package:dartz/dartz.dart';
import 'package:get_storage/src/storage_impl.dart';
import 'package:injectable/injectable.dart';
import 'package:shortes/core/failure/failure.dart';
import 'package:shortes/features/main_page/data/datasources/main_page_data_source.dart';
import 'package:shortes/features/main_page/domain/entities/user_note.dart';
import 'package:shortes/features/main_page/domain/repositories/main_page_repo.dart';
import 'package:shortes/features/main_page/main_page_failures.dart';

@Singleton(as: MainPageRepo)
class MainPageRepoImp implements MainPageRepo{
  final MainPageDataSource dataSource;
  const MainPageRepoImp({required this.dataSource});

  @override
  Future<Either<Failure, List<dynamic>>> getUserNotes({required GetStorage getStorage}) async{
    try{
      final result = await dataSource.getUserNotes(getStorage: getStorage);
      return Right(result);
    }catch(error){
      return const Left(GetUserNotesFailure(failureMessage: 'Unable to get user notes'));
    }
  }
}