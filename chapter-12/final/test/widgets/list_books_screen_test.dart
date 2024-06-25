import 'dart:io';

import 'package:final_version/di/get_it.dart';
import 'package:final_version/networking/api_service.dart';
import 'package:final_version/screens/list_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  setUpAll(() async {
    HttpOverrides.global = null;
  });
  initAppModule();
  testWidgets('List Book Screen', ListBookWidgetTest);
}

Future<void> ListBookWidgetTest(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: ListBooksScreen()));

  expect(find.byType(ListBooksScreen), findsOneWidget);

}