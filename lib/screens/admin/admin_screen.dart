import 'package:flutter/material.dart';

import '../../data/books_data.dart';
import '../../models/books_model.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isAvailable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Book',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Text('Availability:'),
                  const SizedBox(width: 10.0),
                  Switch(
                    value: _isAvailable,
                    onChanged: (value) {
                      setState(() {
                        _isAvailable = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Perform book addition logic here
                        String title = _titleController.text;
                        String author = _authorController.text;
                        String description = _descriptionController.text;
                        bool isAvailable = _isAvailable;

                        // Create a new Book object
                        Book newBook = Book(
                          title: title,
                          author: author,
                          description: description,
                          isAvailable: isAvailable,
                        );

                        // Add the new book to the library
                        dummyLibrary.books.add(newBook);

                        // Reset the text fields and switch
                        _titleController.clear();
                        _authorController.clear();
                        _descriptionController.clear();
                        setState(() {
                          _isAvailable = true;
                        });

                        // Show a success message
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Success'),
                            content: const Text('The book has been added successfully.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Add Book'),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        // Perform book removal logic here
                        // Remove the book from the library
                        dummyLibrary.books.removeLast();

                        // Show a success message
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Success'),
                            content: const Text('The book has been removed successfully.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Remove Book'),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}






