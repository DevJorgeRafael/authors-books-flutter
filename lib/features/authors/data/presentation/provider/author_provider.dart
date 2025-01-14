import 'package:authors_books/core/exception.dart';
import 'package:authors_books/features/authors/data/models/author_model.dart';
import 'package:authors_books/features/authors/domain/repositories/author_repository.dart';
import 'package:flutter/material.dart';

class AuthorProvider with ChangeNotifier{
  final AuthorRepository repository;

  List<Author> _authors = [];
  bool _isLoading = false;
  String? _errorMessage;

  AuthorProvider({required this.repository});

  List<Author> get authors => _authors;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> getAuthors() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _authors = await repository.getAuthors();
    } catch(e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createAuthor(Author author) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.createAuthor(author);
      _authors.add(author);
    } catch(e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAuthor(Author author) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.updateAuthor(author);
      final index = _authors.indexWhere((element) => element.id == author.id);
      _authors[index] = author;
    } catch(e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAuthor(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.deleteAuthor(id);
      _authors.removeWhere((element) => element.id == id);
    } catch(e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Mapeo de errores a mensajes
  String _mapErrorToMessage(Object error) {
    if (error is ServerException) {
      return error.message;
    } else if (error is NetWorkException) {
      return error.message;
    } else {
      return 'Error desconocido: $error';
    }
  }
}