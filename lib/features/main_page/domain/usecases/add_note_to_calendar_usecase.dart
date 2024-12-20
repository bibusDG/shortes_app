import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shortes/core/failure/failure.dart';
import 'package:shortes/core/usecases/usecases.dart';
import 'package:shortes/features/main_page/domain/repositories/main_page_repo.dart';

@injectable
class AddNoteToCalendarUseCase implements UseCaseWithParams<Event, AddToCalendarParams>{
  final MainPageRepo repo;
  const AddNoteToCalendarUseCase({required this.repo});

  @override
  Future<Either<Failure, Event>> call(params) async{
    return await repo.addNoteToCalendar(noteTitle: params.noteTitle, noteContent: params.noteContent);
  }
}

class AddToCalendarParams extends Equatable{
  final String noteTitle;
  final String noteContent;
  const AddToCalendarParams({
    required this.noteContent,
    required this.noteTitle
});

  @override
  List<Object> get props => [noteTitle, noteContent];
}