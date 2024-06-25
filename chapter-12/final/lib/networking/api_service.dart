import 'package:dio/dio.dart';
import 'package:final_version/databases/book_database.dart';
import 'package:final_version/service_locators/service_locator.dart';
import 'package:final_version/shared_preferences/token_preferences.dart';
import 'package:final_version/utils/validations.dart';
import 'package:get_it/get_it.dart';

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
    String? token =
        await ServiceLocator.getService<TokenPreferences>('preferences')
            .getToken();

    dio.options.headers['authorization'] = "bearer $token";
    Response response = await dio.post('/books', data: body);
    print(response);
    List<dynamic> books = response.data;
    print(books);
    await DatabaseBooks().insertBook({'name': books.last['name']});
    return response;
  }

 Future<dynamic> updateBookById(int bookId, String newBookName) async {
    Response? response;
    if (Validations.validateUpdateBook(bookId, newBookName)) {
      var dio = await GetIt.instance<DioClient>().dio;
      String? token =
          await ServiceLocator.getService<TokenPreferences>('preferences')
              .getToken();
      dio.options.headers['authorization'] = "bearer $token";
      response =
          await dio.put('/books', data: {'id': bookId, 'name': newBookName});
      //List<dynamic> books = response.data;
      // await DatabaseBooks().insertBook({'name': books.last['name']});
      return response;
    }
    return null;
  }

  Future<Response> login(Map<String, dynamic> body) async {
    Response response =
        await GetIt.instance<DioClient>().dio.post('/login', data: body);
    await ServiceLocator.getService('preferences')
        .saveToken(response.data['token']);
    return response;
  }
}
