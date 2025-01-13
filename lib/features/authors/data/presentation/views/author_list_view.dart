import 'package:authors_books/features/authors/data/presentation/provider/author_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorListView extends StatelessWidget {
  const AuthorListView({super.key});

  @override
  Widget build(BuildContext context) {
    final authorProvider = Provider.of<AuthorProvider>(context);

    if (authorProvider.authors.isEmpty && !authorProvider.isLoading) {
      Future.microtask(() => authorProvider.getrAuthors());
    }

    return Container(
      child: authorProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: authorProvider.authors.length,
              itemBuilder: (context, index) {
                final author = authorProvider.authors[index];
                return ListTile(
                  title: Text('ID: ${author.id}'),
                  subtitle: Text('${author.name} ${author.lastname}', style: const TextStyle(fontWeight: FontWeight.bold),),
                  trailing: Wrap(
                    spacing: 8.0, // Espaciado entre los botones
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black),
                        tooltip: 'Editar',
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Eliminar',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  onTap: () {
                    // Acción al seleccionar la fila completa
                  },
                );
              },
            ),
    );
  }
}