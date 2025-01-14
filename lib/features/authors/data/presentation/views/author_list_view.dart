import 'package:authors_books/features/authors/data/models/author_model.dart';
import 'package:authors_books/features/authors/data/presentation/pages/add_author_form.dart';
import 'package:authors_books/features/authors/data/presentation/pages/author_details_page.dart';
import 'package:authors_books/features/authors/data/presentation/provider/author_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorListView extends StatefulWidget {
  const AuthorListView({super.key});

  @override
  State<AuthorListView> createState() => _AuthorListViewState();
}

class _AuthorListViewState extends State<AuthorListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthorProvider>(context, listen: false).getAuthors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authorProvider = Provider.of<AuthorProvider>(context);

    return Column(
      children: [
        if (authorProvider.errorMessage != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              authorProvider.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        Expanded(
          child: authorProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  itemCount: authorProvider.authors.length,
                  itemBuilder: (context, index) {
                    final author = authorProvider.authors[index];
                    return AuthorListTile(author: author);
                  },
                ),
        ),
      ],
    );
  }
}

class AuthorListTile extends StatelessWidget {
  const AuthorListTile({
    super.key,
    required this.author,
  });

  final Author author;

  @override
  Widget build(BuildContext context) {
    final authorProvider = Provider.of<AuthorProvider>(context, listen: false);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          author.name[0], // Inicial del nombre
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        '${author.name} ${author.lastname}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Fecha de nacimiento: ${author.formattedBirthDate}'),
      trailing: Wrap(
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            tooltip: 'Editar',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAuthorForm(author: author),
                  ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            tooltip: 'Eliminar',
            onPressed: () {
              authorProvider.deleteAuthor(author.id);
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthorDetailsPage(author: author),
            ));
      },
    );
  }
}
