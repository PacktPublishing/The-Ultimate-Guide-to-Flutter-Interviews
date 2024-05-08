
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:starter/databases/book_database.dart';
import 'package:starter/service_locators/service_locator.dart';
import 'package:starter/shared_preferences/token_preferences.dart';

import 'dio_client.dart';

class ApiService {
  DatabaseBooks _databaseBooks;

  ApiService(this._databaseBooks);

  Future<dynamic> getBooks() async {

    List dataBooks = await _databaseBooks.getBooks();
    if (dataBooks.isEmpty) {
      Response response = await GetIt.instance<DioClient>().dio.get('/books');
      List<dynamic> books = response.data['books'];
      for (var book in books) {
        await _databaseBooks.insertBook({'name': book['name']});
        print(book);
      }
      print('from remote');
      return books;
    }
    print('from database');
    return dataBooks;
  }

  Future<Response> createBook(Map<String, dynamic> body) async {
    print(body);
    var dio = await GetIt.instance<DioClient>().dio;
    String? token =await ServiceLocator.getService<TokenPreferences>('preferences').getToken();

    dio.options.headers['authorization'] = "bearer $token";
    Response response = await dio.post('/books', data:body);
    print(response);
    List<dynamic> books = response.data;
    print(books);
    await DatabaseBooks().insertBook({'name': books.last['name']});
    return response;
  }

  Future<Response> login(Map<String, dynamic> body) async {
    Response response =  await GetIt.instance<DioClient>().dio.post('/login', data: body);
    await ServiceLocator.getService('preferences').saveToken(response.data['token']);
    return response;
  }
}
