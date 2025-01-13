import 'package:authors_books/features/authors/data/presentation/provider/author_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:authors_books/core/dio_client.dart';
import 'package:authors_books/features/authors/data/datasources/author_remote_datasource.dart';
import 'package:authors_books/features/authors/data/repositories/author_repository_impl.dart';
import 'package:authors_books/features/authors/domain/repositories/author_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // --------------------- Dependencias Globales ---------------------
  sl.registerLazySingleton(() => Dio(BaseOptions(
        baseUrl: 'http://localhost:3000', // Ajusta la URL según tu API
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {'Content-Type': 'application/json'},
      )));

  sl.registerLazySingleton(() => DioClient()); // Registro de DioClient

  // --------------------- Dependencias de la App ---------------------
  sl.registerLazySingleton(
      () => AuthorRemoteDatasource()); // Data Source
  sl.registerLazySingleton<AuthorRepository>(
    () => AuthorRepositoryImpl(remoteDatasource: sl()), // Repositorio
  );
  sl.registerLazySingleton(() => AuthorProvider(repository: sl())); // Provider
}
