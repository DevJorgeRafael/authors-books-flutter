import 'package:authors_books/features/authors/data/datasources/author_remote_datasource.dart';
import 'package:authors_books/features/authors/data/models/author_model.dart';
import 'package:authors_books/features/authors/domain/repositories/author_repository.dart';

class AuthorRepositoryImpl implements AuthorRepository {
  final AuthorRemoteDatasource remoteDatasource;

  AuthorRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Author> createAuthor(Author author) {
    return remoteDatasource.createAuthor(author);
  }

  @override
  Future<void> deleteAuthor(int id) {
    return remoteDatasource.deleteAuthor(id);
  }

  @override
  Future<Author> getAuthor(int id) {
    return remoteDatasource.getAuthor(id);
  }

  @override
  Future<List<Author>> getAuthors() {
    return remoteDatasource.getAllAuthors();
  }

  @override
  Future<Author> updateAuthor(Author author) {
    return remoteDatasource.updateAuthor(author);
  }

}