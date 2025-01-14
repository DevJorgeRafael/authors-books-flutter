import 'package:authors_books/core/exception.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.1.8:3000',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        'Content-Type': 'application/json',
      }));

  static Dio get instance => _dio;

  static void handleDioException(DioException error) {
    if (error.response != null) {
      throw ServerException(
        error.response?.data['message'] ?? 'Error desconocido del servidor'
      );
    } else {
      throw NetWorkException('Error de red: $error');
    }
  }
}
