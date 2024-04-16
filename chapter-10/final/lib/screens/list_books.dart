import 'package:flutter/material.dart';

class ListBooksScreen extends StatefulWidget {
  const ListBooksScreen({super.key});

  @override
  State<ListBooksScreen> createState() => _ListBooksScreenState();
}

class _ListBooksScreenState extends State<ListBooksScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> books = ['Book 1', 'Book 2', 'Book 3', 'Book 4'];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Books',style: TextStyle(color: Colors.white),),
        ),
        body: FutureBuilder(
          future: null,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
           return Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(books[index]),
                  );
                },
                itemCount: books.length,
              ),
            );
          },
        ));
  }
}
