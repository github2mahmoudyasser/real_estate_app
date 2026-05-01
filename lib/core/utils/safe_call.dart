// core/utils/safe_call.dart

import 'package:fpdart/fpdart.dart';

import '../errors/exceptions.dart';
import '../errors/failures.dart';

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);
  } on NetworkException {
    return Left(NetworkFailure());
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } on CacheException {
    return Left(CacheFailure());
  } catch (e) {
    return Left(UnknownFailure(e.toString()));
  }
}
