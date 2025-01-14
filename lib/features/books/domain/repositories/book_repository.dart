import 'package:authors_books/features/books/data/models/book_model.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();
  Future<Book> getBook(int id);
  Future<Book> createBook(Book book);
  Future<Book> updateBook(Book book);
  Future<void> deleteBook(int id);
}