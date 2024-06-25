import 'package:flutter_test/flutter_test.dart';
import 'package:final_version/calculator.dart';
void main() {
  group('Calculator', () {
    test('should return the sum of two numbers', () {
      // Arrange
      int a = 2;
      int b = 3;

      // Act
      int result = Calculator.sumNumbers(a, b);

      // Assert
      expect(result, 5);
    });
  });
}

