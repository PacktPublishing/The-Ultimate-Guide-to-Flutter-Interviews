import 'package:final_version/databases/book_database.dart';
import 'package:final_version/networking/api_service.dart';
import 'package:final_version/networking/dio_client.dart';
import 'package:final_version/shared_preferences/token_preferences.dart';
import 'package:get_it/get_it.dart';


final instance = GetIt.instance;

Future<GetIt> initAppModule() async {
 DatabaseBooks databaseBooks = GetIt.I.registerSingleton<DatabaseBooks>(DatabaseBooks());
  GetIt.I.registerSingleton<DioClient>(DioClient());
  GetIt.I.registerSingleton<TokenPreferences>(TokenPreferences());
  GetIt.I.registerSingleton<ApiService>(ApiService(databaseBooks));
  return instance;
}