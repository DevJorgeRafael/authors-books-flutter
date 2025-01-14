import 'package:authors_books/features/authors/data/models/author_model.dart';
import 'package:flutter/material.dart';

class AuthorDetailsPage extends StatelessWidget {
  final Author author;
  const AuthorDetailsPage({super.key, required this.author});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del autor'),
        actions:  [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red,),
            onPressed: () {},
          ),
          const SizedBox(width: 16)
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(author.name[0], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 16),
            Text(
              '${author.name} ${author.lastname}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(author.formattedBirthDate, style: const TextStyle(fontSize: 16),),
          ],
        ),
      ) 
    );
  }
}