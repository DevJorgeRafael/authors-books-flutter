class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}

class NetWorkException implements Exception {
  final String message;

  NetWorkException(this.message);

  @override
  String toString() => 'NetWorkException: $message';
}