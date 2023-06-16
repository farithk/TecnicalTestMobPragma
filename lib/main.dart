import 'package:flutter/material.dart';

import 'Views/cat_cards.dart';

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
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        textTheme: const TextTheme(
        ),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 0, 67, 150),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        primaryColor: const Color.fromARGB(255, 0, 0, 0),
        fontFamily: 'Montserrat',
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(8),
          hintStyle: TextStyle(color: Color.fromRGBO(42, 42, 42, 0.498)),
        ),
        
      ),
      
      home: const MyHomePage(title: 'CatBreeds'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const CatCards()
    );
  }
}
