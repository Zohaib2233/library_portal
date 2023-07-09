import 'package:flutter/material.dart';
import 'package:library_portal/screens/main_Screen.dart';
import 'package:library_portal/screens/registration/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: const Color(0xff213E94)
        )
      ),
      home: const MainScreen()
    );
  }
}


