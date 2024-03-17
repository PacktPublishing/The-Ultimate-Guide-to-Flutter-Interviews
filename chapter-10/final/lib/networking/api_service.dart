import 'package:dio/dio.dart';

import 'dio_client.dart';

class ApiService {
  Future<Response> getBooks() async {
    Response response = await DioClient().dio.get('/books');
    print(' response status code ${response.statusCode}');
    return response;
  }

  Future<Response> createBook(Map<String, dynamic> body) async {
    Response response = await DioClient().dio.post('/books', data: body);
    return response;
  }
  Future<Response> login(Map<String, dynamic> body) async {
    Response response = await DioClient().dio.post('/login', data: body);
    print(response);
    return response;
  }
}
