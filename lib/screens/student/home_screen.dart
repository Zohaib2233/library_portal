import 'package:flutter/material.dart';
import 'package:library_portal/screens/registration/login.dart';

import '../../models/library_model.dart';
import 'bookdetail_screen.dart';

class HomeScreen extends StatelessWidget {
  final Library library;

  const HomeScreen({super.key, required this.library});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Abhishek Mishra"),
              accountEmail: Text("abhishekm977@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home), title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings), title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout), title: Text("Logout"),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
            ),
          ],
        ),
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