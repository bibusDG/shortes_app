import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shortes/core/failure/failure.dart';
import 'package:shortes/core/usecases/usecases.dart';
import 'package:shortes/features/main_page/domain/repositories/main_page_repo.dart';

@injectable
class DeleteNoteUseCase implements UseCaseWithParams<void, DeleteNoteParams>{
  final MainPageRepo repo;
  const DeleteNoteUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(params) async{
    return await repo.deleteNote(getStorage: params.getStorage, index: params.index);
  }
}

class DeleteNoteParams extends Equatable{
  final GetStorage getStorage;
  final int index;
  const DeleteNoteParams({
    required this.getStorage,
    required this.index,
});

  @override
  List<Object> get props => [getStorage, index];

}