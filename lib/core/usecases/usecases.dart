import 'package:dartz/dartz.dart';

import '../failure/failure.dart';

abstract class UseCaseWithParams<Type, Params>{
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseWithoutParams<Type>{
  Future<Either<Failure, Type>> call();
}