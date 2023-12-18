import 'package:employee_connect/core/extension/app_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtension extension', () {
    test('isValid should return true for a non-empty string', () {
      // Arrange
      const nonEmptyString = 'Hello, World!';

      // Act
      final isValid = nonEmptyString.isValid;

      // Assert
      expect(isValid, isTrue);
    });

    test('isValid should return false for an empty string', () {
      // Arrange
      const emptyString = '';

      // Act
      final isValid = emptyString.isValid;

      // Assert
      expect(isValid, isFalse);
    });

    test('isValid should return false for a string with only whitespaces', () {
      // Arrange
      const stringWithWhitespaces = '    ';

      // Act
      final isValid = stringWithWhitespaces.isValid;

      // Assert
      expect(isValid, isFalse);
    });

  });
}
