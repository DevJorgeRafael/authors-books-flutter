import 'package:authors_books/features/authors/data/presentation/pages/author_form_page.dart';
import 'package:authors_books/features/authors/data/presentation/views/author_list_view.dart';
import 'package:authors_books/features/books/data/presentation/views/book_list_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final views = [
      const AuthorListView(),
      const BookListView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Autores" : "Libros"),
        actions: [
          _selectedIndex == 0 ? IconButton(
            icon: const Icon(Icons.person_add_alt_rounded),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAuthorForm(author: null)));
            },
          ): 
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {}, 
          )
          , const SizedBox(width: 16)
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: views,
      ),
      bottomNavigationBar: _customBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}

Widget _customBottomNavigationBar({
  required int selectedIndex,
  required void Function(int) onItemSelected,
}) {
  return BottomNavigationBar(
      elevation: 4,
      type: BottomNavigationBarType.shifting,
      backgroundColor: Colors.white,
      currentIndex: selectedIndex,
      onTap: (value) {
        onItemSelected(value);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded), 
          label: "Autores",
          backgroundColor: Colors.blue
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_rounded), 
          label: "Libros",
          backgroundColor: Colors.blue
          ),
      ],
    );
}
