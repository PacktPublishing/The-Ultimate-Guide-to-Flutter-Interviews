import 'package:dio/dio.dart';
import 'package:final_version/networking/api_service.dart';
import 'package:final_version/utils/validations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ValidationsStub {
  static bool validateUpdateBook(int bookId, String newBookName) {
    return bookId > 0 && newBookName.isNotEmpty;
  }
}

// Mock class for DioClient
class MockApiService extends Mock implements ApiService {}

// Mock class for TokenPreferences
void main() {
  late MockApiService? mockApiService;
  group('updateBookById', () {
    // Initial setup for mocks
    setUp(() async {
      mockApiService = MockApiService();
    });

    test('returns true for a valid book ID and a non-empty name', () async {
      final result = Validations.validateUpdateBook(1, 'New Book Name');
      expect(result, isTrue);
    });
    test('returns false for invalid book ID', () async {
      final bookId = 0;
      final newBookName = 'Valid Book Name';
      final result = ValidationsStub.validateUpdateBook(bookId, newBookName);
      expect(result, isFalse);
    });
    test('updates book successfully with valid data', () async {
      final bookId = 1;
      final newBookName = 'Updated Book Name';
      when(()=>mockApiService?.updateBookById(bookId, newBookName)).thenAnswer(
              (_) async => Response(
              data: {'id': bookId, 'name': newBookName},
              requestOptions: RequestOptions()));

      Response result = await mockApiService?.updateBookById(bookId, newBookName);
      // Verify that the book was updated successfully
      expect(result, isNotNull);
      expect(result.data['id'], bookId);
      expect(result.data['name'], newBookName);
    });

  });
}
