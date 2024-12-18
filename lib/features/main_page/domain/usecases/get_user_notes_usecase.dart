import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shortes/core/failure/failure.dart';
import 'package:shortes/core/usecases/usecases.dart';
import 'package:shortes/features/main_page/domain/entities/user_note.dart';
import 'package:shortes/features/main_page/domain/repositories/main_page_repo.dart';

@injectable
class GetUserNotesUseCase implements UseCaseWithParams<List<dynamic>, GetUserNotesParams>{
  final MainPageRepo repo;
  const GetUserNotesUseCase({required this.repo});

  @override
  Future<Either<Failure, List<dynamic>>> call(params) async{
    return await repo.getUserNotes(getStorage: params.getStorage);
  }
}

class GetUserNotesParams extends Equatable{
  final GetStorage getStorage;
  const GetUserNotesParams({required this.getStorage});

  @override
  List<Object> get props => [getStorage];
}