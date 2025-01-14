import 'package:authors_books/core/dio_client.dart';
import 'package:authors_books/features/authors/data/models/author_model.dart';
import 'package:dio/dio.dart';

class AuthorRemoteDatasource {
  Future<List<Author>> getAllAuthors() async {
    try {
      final response = await DioClient.instance.get('/authors');
      return (response.data as List).map((e) => Author.fromJson(e)).toList();
    } on DioException catch (e) {
      DioClient.handleDioException(e);
      rethrow;
    }
  }

  Future<Author> getAuthor(int id) async {
    try {
      final response = await DioClient.instance.get('/authors/$id');
      return Author.fromJson(response.data);
    } on DioException catch (e) {
      DioClient.handleDioException(e);
      rethrow;
    }
  }

  Future<Author> createAuthor(Author author) async {
    try {
      final data = {
        'name': author.name,
        'lastname': author.lastname,
        'birthDate': author.birthDate.toIso8601String(),
      };
      final response = await DioClient.instance.post('/authors', data: data);

      return Author.fromJson(response.data);
    } on DioException catch (e) {
      DioClient.handleDioException(e);
      rethrow;
    }
  }

  Future<Author> updateAuthor(Author author) async {
    try {
      final response = await DioClient.instance.put('/authors/${author.id}', data: author.toJson());
      return Author.fromJson(response.data);
    } on DioException catch (e) {
      DioClient.handleDioException(e);
      rethrow;
    }
  }

  Future<bool> deleteAuthor(int id) async {
    try {
      await DioClient.instance.delete('/authors/$id');
      return true;
    } on DioException catch (e) {
      DioClient.handleDioException(e);
      rethrow;
    }
  }
}