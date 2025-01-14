
import 'package:authors_books/features/books/data/datasources/book_remote_datasource.dart';
import 'package:authors_books/features/books/data/models/book_model.dart';
import 'package:authors_books/features/books/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDatasource remoteDatasource;

  BookRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Book> createBook(Book book) {
    try {
      return remoteDatasource.createBook(book);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBook(int id) {
    try {
      return remoteDatasource.deleteBook(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Book> getBook(int id) {
    try {
      return remoteDatasource.getBook(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Book>> getBooks() {
    try {
      return remoteDatasource.getAllBooks();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Book> updateBook(Book book) {
    try {
      return remoteDatasource.updateBook(book);
    } catch (e) {
      rethrow;
    }
  }

}