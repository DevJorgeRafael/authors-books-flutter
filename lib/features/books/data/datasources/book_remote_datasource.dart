import 'package:authors_books/core/dio_client.dart';
import 'package:authors_books/features/books/data/models/book_model.dart';
import 'package:dio/dio.dart';

class BookRemoteDatasource {
  Future<List<Book>> getAllBooks() async {
    try {
      final response = await DioClient.instance.get('/books');
      return (response.data as List).map((e) => Book.fromJson(e)).toList();
    } on DioException catch (e) {
      DioClient.handleDioException(e);
      rethrow;
    }
  }

  Future<Book> getBook(int id) async {
    try {
      final response = await DioClient.instance.get('/books/$id');
      return Book.fromJson(response.data);
    } on DioException catch (e) {
      DioClient.handleDioException(e);
      rethrow;
    }
  }

  Future<Book> createBook(Book book) async {
    final data = {
      'title': book.title,
      'literary_genre': book.literaryGenre,
      'publication_date': book.publicationDate.toIso8601String(),
      'language': book.language,
    };

    try {
      final response = await DioClient.instance.post('/books', data: data);
      return Book.fromJson(response.data);
    } on DioException catch (e) {
      DioClient.handleDioException(e);
      rethrow;
    }
  }

  Future<Book> updateBook(Book book) async {
    final data = {
      'title': book.title,
      'literary_genre': book.literaryGenre,
      'publication_date': book.publicationDate.toIso8601String(),
      'language': book.language,
    };

    try {
      final response = await DioClient.instance.put('/books/${book.id}', data: data);
      return Book.fromJson(response.data);
    } on DioException catch (e) {
      DioClient.handleDioException(e);
      rethrow;
    }
  }

  Future<bool> deleteBook(int id) async {
    try {
      await DioClient.instance.delete('/books/$id');
      return true;
    } on DioException catch (e) {
      DioClient.handleDioException(e);
      rethrow;
    }
  }
}