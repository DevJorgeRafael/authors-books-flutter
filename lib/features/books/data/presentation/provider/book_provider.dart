import 'package:authors_books/core/exception.dart';
import 'package:authors_books/features/books/data/models/book_model.dart';
import 'package:authors_books/features/books/domain/repositories/book_repository.dart';
import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier{
  final BookRepository repository;

  List<Book> _books = [];
  bool _isLoading = false;
  String? _errorMessage;

  BookProvider({required this.repository});

  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> getAuthors() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _books = await repository.getBooks();
    } catch(e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createBook(Book book) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.createBook(book);
      _books.add(book);
    } catch(e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBook(Book book) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.updateBook(book);
      final index = _books.indexWhere((element) => element.id == book.id);
      _books[index] = book;
    } catch(e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBook(Book book) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.deleteBook(book.id);
      _books.removeWhere((element) => element.id == book.id);
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