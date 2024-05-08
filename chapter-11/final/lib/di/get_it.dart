import 'package:get_it/get_it.dart';
import 'package:starter/databases/book_database.dart';
import 'package:starter/networking/api_service.dart';
import 'package:starter/networking/dio_client.dart';
import 'package:starter/shared_preferences/token_preferences.dart';

final instance = GetIt.instance;

Future<GetIt> initAppModule() async {
 DatabaseBooks databaseBooks = GetIt.I.registerSingleton<DatabaseBooks>(DatabaseBooks());
  GetIt.I.registerSingleton<DioClient>(DioClient());
  GetIt.I.registerSingleton<TokenPreferences>(TokenPreferences());
  GetIt.I.registerSingleton<ApiService>(ApiService(databaseBooks));
  return instance;
}