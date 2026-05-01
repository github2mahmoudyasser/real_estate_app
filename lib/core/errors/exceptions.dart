class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Server error occurred']);
}

class NetworkException implements Exception {
  const NetworkException();
}

class CacheException implements Exception {
  const CacheException();
}