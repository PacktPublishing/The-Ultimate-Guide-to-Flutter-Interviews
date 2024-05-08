import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio _dio;

  DioClient() : _dio = Dio() {
    _dio.options = BaseOptions(
        baseUrl: 'http://192.168.0.100:3000',
        contentType: 'application/json',
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15));
  }

  Dio get dio => _dio;
}
