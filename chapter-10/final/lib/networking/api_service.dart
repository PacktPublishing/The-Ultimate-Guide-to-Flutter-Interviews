import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/databases/book_database.dart';

import 'dio_client.dart';

class ApiService {
  Future<dynamic> getBooks() async {

    List dataBooks = await DatabaseBooks().getBooks();
    if (dataBooks.isEmpty) {
      Response response = await DioClient().dio.get('/books');
      List<dynamic> books = response.data['books'];
      for (var book in books) {
        await DatabaseBooks().insertBook({'name': book['name']});
        print(book);
      }
      print('from remote');
      return books;
    }
    print('from database');
    return dataBooks;
  }

  Future<Response> createBook(Map<String, dynamic> body) async {
    var dio = DioClient().dio;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers['authorization'] = "bearer $token";
    Response response = await dio.post('/books', data:body);
    List<dynamic> books = response.data['books'];
    print(books);
    await DatabaseBooks().insertBook({'name': books.last['name']});
    return response;
  }

  Future<Response> login(Map<String, dynamic> body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await DioClient().dio.post('/login', data: body);
    await prefs.setString('token', response.data['token']);
    String? token = prefs.getString('token');
    print("Token is in SharePreferences: $token");
    return response;
  }
}
