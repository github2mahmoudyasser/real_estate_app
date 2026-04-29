import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// 🔴 Server
class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Something went wrong, please try again',
  ]);
}

// 🌐 Network
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

// 🔐 Auth
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Session expired, please login again',
  ]);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure([
    super.message = 'You are not allowed to access this',
  ]);
}

// 🔍 Data
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Data not found']);
}

class EmptyDataFailure extends Failure {
  const EmptyDataFailure([super.message = 'No data available']);
}

// 🧾 Validation
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Invalid input']);
}

// 💾 Cache
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error']);
}

// ❓ Fallback
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Unexpected error occurred']);
}
