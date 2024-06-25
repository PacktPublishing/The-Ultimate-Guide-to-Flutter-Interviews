import 'dart:io';

import 'package:dio/dio.dart';
import 'package:final_version/di/get_it.dart';
import 'package:final_version/networking/api_service.dart';
import 'package:final_version/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  setUpAll(()  {
    HttpOverrides.global = null;
  });
  initAppModule();
  testWidgets('Home Screen', HomeWidgetTest);
}

Future<void> HomeWidgetTest(WidgetTester tester) async {
  Map<String, dynamic> credentials = {
    "email": "oto@mail.com",
    "password": "123456"
  };
  MockApiService mockApiService = MockApiService();
  await tester.pumpWidget(MaterialApp(home: HomeScreen()));
  when(() => mockApiService.login(credentials)).thenAnswer((_) async =>
      Response(
          data: {'token': 'abc'},
          statusCode: 200,
          requestOptions: RequestOptions()));
  expect(find.text('Home'), findsOneWidget);
  expect(find.byType(AppBar), findsOneWidget);
  expect(find.byType(SingleChildScrollView), findsOneWidget);

  expect(find.byKey(Key('emailField')), findsOneWidget);

  expect(find.byKey(Key('passwordField')), findsOneWidget);

  expect(find.byType(Image), findsOneWidget);

  expect(find.byKey(Key('sendButton')), findsOneWidget);
  expect(find.text('Send'), findsOneWidget);
  await mockApiService.login(credentials);
  verify(()=>mockApiService.login(credentials)).called(1);

}
