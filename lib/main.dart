import 'package:authors_books/app.dart';
import 'package:authors_books/shared/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp(home: HomePage(),));
}
