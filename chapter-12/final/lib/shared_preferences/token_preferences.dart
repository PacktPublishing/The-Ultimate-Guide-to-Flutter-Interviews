import 'package:shared_preferences/shared_preferences.dart';

class TokenPreferences  {


  saveToken(String token)async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    return  prefs.getString('token');
  }

}
