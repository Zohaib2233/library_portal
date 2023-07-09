import 'package:flutter/material.dart';

import '../../models/library_model.dart';
import 'bookdetail_screen.dart';

class BookListScreen extends StatelessWidget {
  final Library library;

  const BookListScreen({super.key, required this.library});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
      ),
      body: ListView.builder(
        itemCount: library.books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(library.books[index].title),
            subtitle: Text(library.books[index].author),
            trailing: library.books[index].isAvailable
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.highlight_off, color: Colors.red),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsScreen(book: library.books[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}