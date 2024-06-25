import 'package:final_version/databases/book_database.dart';
import 'package:final_version/screens/home_screen.dart';
import 'package:final_version/service_locators/service_locator.dart';
import 'package:final_version/shared_preferences/token_preferences.dart';
import 'package:flutter/material.dart';


import 'di/get_it.dart';

void main()async {
  await initAppModule();

  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseBooks().getDataBase();
  ServiceLocator.registerService('preferences', TokenPreferences());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}


