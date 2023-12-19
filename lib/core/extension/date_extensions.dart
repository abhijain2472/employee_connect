import 'package:intl/intl.dart';

extension FormattedDate on DateTime {
  String get dMMMYYYY => DateFormat('d MMM, yyyy').format(this);

  String get toStartDateText {
    if (isTodayDate) return 'Today';
    return dMMMYYYY;
  }

  bool get isTodayDate {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  bool isBetween(DateTime startDate, DateTime endDate) {
    return isAfter(startDate) && isBefore(endDate);
  }

  DateTime get nextMonday {
    int daysUntilNextMonday = DateTime.monday - weekday;
    if (daysUntilNextMonday <= 0) {
      daysUntilNextMonday += 7;
    }
    return add(Duration(days: daysUntilNextMonday));
  }

  DateTime get nextTuesday {
    int daysUntilNextTuesday = DateTime.tuesday - weekday;
    if (daysUntilNextTuesday <= 0) {
      daysUntilNextTuesday += 7;
    }
    return add(Duration(days: daysUntilNextTuesday));
  }

  DateTime get nextWeek => add(const Duration(days: 7));

}

extension SameDate on DateTime? {
  bool isSameDate(DateTime date) {
    if (this == null) return false;
    return this!.year == date.year &&
        this!.month == date.month &&
        this!.day == date.day;
  }
}

extension DateExtension on String {
  DateTime get toDateTime => DateTime.tryParse(this) ?? DateTime.now();

  DateTime? get toDateTimeN => DateTime.tryParse(this);
}
