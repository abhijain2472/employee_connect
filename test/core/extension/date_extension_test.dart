import 'package:employee_connect/core/extension/date_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_objects.dart';

void main() {
  group('FormattedDate extension', () {
    test('dMMMYYYY should format date correctly', () {
      // Arrange
      final dateTime = tDate;
      // Act
      final formattedDate = dateTime.dMMMYYYY;
      // Assert
      expect(formattedDate, equals('15 Jan, 2023'));
    });

    test('toStartDateText should return "Today" for today\'s date', () {
      // Arrange
      final today = DateTime.now();

      // Act
      final startDateText = today.toStartDateText;

      // Assert
      expect(startDateText, equals('Today'));
    });

    test('toStartDateText should return formatted date for non-today date', () {
      // Arrange
      final date = tDate;

      // Act
      final startDateText = date.toStartDateText;

      // Assert
      expect(startDateText, equals('15 Jan, 2023'));
    });

    test('isTodayDate should return true for today\'s date', () {
      // Arrange
      final today = DateTime.now();

      // Act
      final isToday = today.isTodayDate;

      // Assert
      expect(isToday, isTrue);
    });

    test('isTodayDate should return false for non-today date', () {
      // Act
      final isToday = tDate.isTodayDate;

      // Assert
      expect(isToday, isFalse);
    });

    test('isBetween should return true for a date between start and end dates',
        () {
      // Arrange
      final startDate = DateTime(2023, 1, 1);
      final endDate = DateTime(2023, 12, 31);
      final date = DateTime(2023, 6, 15);

      // Act
      final isBetween = date.isBetween(startDate, endDate);

      // Assert
      expect(isBetween, isTrue);
    });

    test('isBetween should return false for a date outside start and end dates',
        () {
      // Arrange
      final startDate = DateTime(2023, 1, 1);
      final endDate = DateTime(2023, 12, 31);
      final dateBeforeStart = DateTime(2022, 12, 31);
      final dateAfterEnd = DateTime(2024, 1, 1);

      // Act
      final isBeforeStart = dateBeforeStart.isBetween(startDate, endDate);
      final isAfterEnd = dateAfterEnd.isBetween(startDate, endDate);

      // Assert
      expect(isBeforeStart, isFalse);
      expect(isAfterEnd, isFalse);
    });
  });

  group('SameDate extension', () {
    test('isSameDate should return true for the same date', () {
      // Arrange
      final date = DateTime(2023, 1, 15);
      final sameDate = DateTime(2023, 1, 15);

      // Act
      final isSame = date.isSameDate(sameDate);

      // Assert
      expect(isSame, isTrue);
    });

    test('isSameDate should return false for different dates', () {
      // Arrange
      final date = DateTime(2023, 1, 15);
      final differentDate = DateTime(2023, 1, 16);

      // Act
      final isSame = date.isSameDate(differentDate);

      // Assert
      expect(isSame, isFalse);
    });

    test('isSameDate should return false when the input date is null', () {
      // Arrange
      DateTime? nullDate;

      // Act
      final isSame = nullDate.isSameDate(tDate);

      // Assert
      expect(isSame, isFalse);
    });
  });

  group('DateExtension extension', () {
    test('toDateTime should parse string to DateTime', () {
      // Act
      final dateTime = tDateString.toDateTime;

      // Assert
      expect(dateTime, equals(tDate));
    });

    test('toDateTimeN should parse string to DateTime or return null', () {
      // Arrange

      const invalidDateString = 'invalid';

      // Act
      final validDateTime = tDateString.toDateTimeN;
      final invalidDateTime = invalidDateString.toDateTimeN;

      // Assert
      expect(validDateTime, equals(tDate));
      expect(invalidDateTime, isNull);
    });
  });
}
