import 'package:authors_books/features/authors/data/datasources/author_remote_datasource.dart';
import 'package:authors_books/features/authors/data/models/author_model.dart';
import 'package:authors_books/features/authors/domain/repositories/author_repository.dart';

class AuthorRepositoryImpl implements AuthorRepository {
  final AuthorRemoteDatasource remoteDatasource;

  AuthorRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Author> createAuthor(Author author) {
    try {
      return remoteDatasource.createAuthor(author);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAuthor(int id) {
    try {
      return remoteDatasource.deleteAuthor(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Author> getAuthor(int id) {
    try {
      return remoteDatasource.getAuthor(id);
    } catch (e) {
      rethrow;
    }  
  }

  @override
  Future<List<Author>> getAuthors() {
    try {
      return remoteDatasource.getAllAuthors();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Author> updateAuthor(Author author) {
    try {
      return remoteDatasource.updateAuthor(author);
    } catch (e) {
      rethrow;
    }
  }

}