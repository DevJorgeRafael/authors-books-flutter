import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:authors_books/features/authors/data/datasources/author_remote_datasource.dart';
import 'package:authors_books/features/authors/data/presentation/provider/author_provider.dart';
import 'package:authors_books/features/authors/data/repositories/author_repository_impl.dart';

/// Configuración de la aplicación con los Providers
class MyApp extends StatelessWidget {
  final Widget home;

  const MyApp({required this.home, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthorProvider(
            repository: AuthorRepositoryImpl(
              remoteDatasource: AuthorRemoteDatasource(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: home,
      ),
    );
  }
}
