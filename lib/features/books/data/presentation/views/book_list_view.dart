import 'package:authors_books/features/books/data/models/book_model.dart';
import 'package:authors_books/features/books/data/presentation/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListView extends StatefulWidget {
  const BookListView({super.key});

  @override
  State<BookListView> createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context, listen: true);

    return Column(
      children: [
        if (bookProvider.errorMessage != null)
          Padding(padding: const EdgeInsets.all(8.0),
            child: Text(
              bookProvider.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        Expanded(
          child: bookProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              ) 
            : ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: Colors.grey,
              ),
              itemCount: bookProvider.books.length,
              itemBuilder: (context, index) {
                final book = bookProvider.books[index];
                return BookListTile(book: book);
              },
            ),
        )
      ],
    );
  }
}

class BookListTile extends StatelessWidget {
  const BookListTile({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);

    return ListTile(
      leading: const Icon(Icons.book,),
      title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Text(book.publicationDate.toIso8601String()),
      trailing: Wrap(
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            tooltip: 'Editar',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthorForm(author: author),
                  ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            tooltip: 'Eliminar',
            onPressed: () {
              bookProvider.deleteBook(book);
            },
          ),
        ],
      ),
    );
  }
}