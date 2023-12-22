import 'package:flutter/material.dart';

class WidgetKeys {
  static const dateSave = Key('date-save');
  static const dateCancel = Key('date-cancel');
  static const empSave = Key('emp-save');
  static const empCancel = Key('emp-cancel');

  static const nameInput = Key('name-input');
  static const roleInput = Key('role-input');
  static const startDateInput = Key('start-date-input');
  static const endDateInput = Key('end-date-input');

  static const nextTuesdayButton = Key('next_tuesday_button');
  static const after1WeekButton = Key('after_1_week_button');
  static const todayButton = Key('today_button');
  static const nextMondayButton = Key('next_monday_button');
  static const noDateButton = Key('no_date_button');
  static const bottomCtaPadding = Key('bottom-padding');
  static const deleteEmpIcon = Key('delete-emp-icon');

  static Key employeeKey(String empId) => Key('e$empId');
}
