import 'package:authors_books/features/authors/data/models/author_model.dart';
import 'package:authors_books/features/authors/domain/repositories/author_repository.dart';
import 'package:flutter/material.dart';

class AuthorProvider with ChangeNotifier{
  final AuthorRepository repository;

  List<Author> _authors = [];
  bool _isLoading = false;

  List<Author> get authors => _authors;
  bool get isLoading => _isLoading;

  AuthorProvider({required this.repository});

  Future<void> getrAuthors() async {
    _isLoading = true;
    notifyListeners();

    _authors = await repository.getAuthors();
    
    _isLoading = false;
    notifyListeners();
  }
}