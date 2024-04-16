import 'package:flutter/material.dart';
import 'package:starter/databases/book_database.dart';
import 'package:starter/screens/list_books.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseBooks().initDB();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ListBooksScreen(),
    );
  }
}


