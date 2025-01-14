import 'package:authors_books/features/authors/data/models/author_model.dart';

abstract class AuthorRepository {
  Future<List<Author>> getAuthors();
  Future<Author> getAuthor(int id);
  Future<Author> createAuthor(Author author);
  Future<Author> updateAuthor(Author author);
  Future<void> deleteAuthor(int id);
}