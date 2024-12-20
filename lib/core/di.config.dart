// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shortes/features/main_page/data/datasources/main_page_data_source.dart'
    as _i1035;
import 'package:shortes/features/main_page/data/repositories/main_page_repo_imp.dart'
    as _i304;
import 'package:shortes/features/main_page/domain/repositories/main_page_repo.dart'
    as _i376;
import 'package:shortes/features/main_page/domain/usecases/add_new_note_usecase.dart'
    as _i925;
import 'package:shortes/features/main_page/domain/usecases/add_note_to_calendar_usecase.dart'
    as _i730;
import 'package:shortes/features/main_page/domain/usecases/delete_note_usecase.dart'
    as _i952;
import 'package:shortes/features/main_page/domain/usecases/get_user_notes_usecase.dart'
    as _i895;
import 'package:shortes/features/main_page/presentation/bloc/main_page_cubit.dart'
    as _i869;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i1035.MainPageDataSource>(
        () => _i1035.MainPageDataSourceImp());
    gh.singleton<_i376.MainPageRepo>(() =>
        _i304.MainPageRepoImp(dataSource: gh<_i1035.MainPageDataSource>()));
    gh.factory<_i730.AddNoteToCalendarUseCase>(
        () => _i730.AddNoteToCalendarUseCase(repo: gh<_i376.MainPageRepo>()));
    gh.factory<_i952.DeleteNoteUseCase>(
        () => _i952.DeleteNoteUseCase(repo: gh<_i376.MainPageRepo>()));
    gh.factory<_i895.GetUserNotesUseCase>(
        () => _i895.GetUserNotesUseCase(repo: gh<_i376.MainPageRepo>()));
    gh.factory<_i925.AddNewNoteUseCase>(
        () => _i925.AddNewNoteUseCase(repo: gh<_i376.MainPageRepo>()));
    gh.factory<_i869.MainPageCubit>(() => _i869.MainPageCubit(
          getUserNotesUseCase: gh<_i895.GetUserNotesUseCase>(),
          addNewNoteUseCase: gh<_i925.AddNewNoteUseCase>(),
          deleteNoteUseCase: gh<_i952.DeleteNoteUseCase>(),
          addNoteToCalendarUseCase: gh<_i730.AddNoteToCalendarUseCase>(),
        ));
    return this;
  }
}
