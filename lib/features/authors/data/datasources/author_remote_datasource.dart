import 'package:authors_books/core/dio_client.dart';
import 'package:authors_books/features/authors/data/models/author_model.dart';

class AuthorRemoteDatasource {

  Future<List<Author>> getAllAuthors() async {
    final resposne = await DioClient.instance.get('/authors');
    return (resposne.data as List).map((e) => Author.fromJson(e)).toList();
  }

  Future<Author> getAuthor(int id) async {
    final resposne = await DioClient.instance.get('/authors/$id');
    return Author.fromJson(resposne.data);
  }

  Future<Author> createAuthor(Author author) async {
    final resposne = await DioClient.instance.post('/authors', data: author.toJson());
    return Author.fromJson(resposne.data);
  }

  Future<Author> updateAuthor(Author author) async {
    final resposne = await DioClient.instance.put('/authors/${author.id}', data: author.toJson());
    return Author.fromJson(resposne.data);
  }

  Future<void> deleteAuthor(int id) async {
    await DioClient.instance.delete('/authors/$id');
  }
}