import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/databases/book_database.dart';
import 'package:starter/shared_preferences/token_preferences.dart';

import 'dio_client.dart';

class ApiService {
  Future<Response> getBooks() async {
    Response response = await DioClient().dio.get('/books');

    print(' response status code ${response.statusCode}');
    await DatabaseBooks().insertBook(response.data);

    return response;
  }

  Future<Response> createBook(Map<String, dynamic> body) async {
    var dio = DioClient().dio;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers['authorization'] = "bearer $token";
    Response response = await dio.post('/books', data:body);
    print(response);
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
