import 'package:final_version/databases/book_database.dart';
import 'package:final_version/networking/api_service.dart';
import 'package:final_version/screens/list_books.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
DatabaseBooks? databaseBooks;

  @override
  Widget build(BuildContext context) {
    databaseBooks = DatabaseBooks();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Image.asset('assets/packt_logo.png'),
                TextFormField(
                  key: const Key('emailField'),
                    decoration: InputDecoration(
                  hintText: 'e-mail',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none, // Remove a borda padrão),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                )),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  key: Key('passwordField'),
                  decoration: InputDecoration(
                    hintText: 'password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none, // Remove a borda padrão
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  key: const Key('sendButton'),
                    onPressed:()async {
                      try{
                       await GetIt.instance<ApiService>().login({"email":"oto@mail.com","password":"123456"});
                       Navigator.of(context).push(
                         MaterialPageRoute(
                           builder: (context) => ListBooksScreen(),
                         ),
                       );
                      }on Exception catch(e){
                        print(e);
                        print('Something went wrong');
                      }
                    },
                    child: Text('Send'))
              ],
            ),
          )),
        ),
      ),
    );
  }
}

