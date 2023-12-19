import 'package:employee_connect/core/extension/date_extensions.dart';
import 'package:employee_connect/feature/employee/presentation/widgets/app_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../helper.dart';

void main() {
  testWidgets('AppDatePicker should render correctly',
      (WidgetTester tester) async {
    DateTime? selectedDate;

    await tester.pumpWidget(
      TestableWidget(
        child: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () async {
              selectedDate = await showAppDatePicker(
                context: context,
              );
            },
            child: const Text('Open DatePicker'),
          ),
        ),
      ),
    );

    await _openDatePicker(tester);
    // Verify that the AppDatePicker is rendered
    expect(find.byType(AppDatePicker), findsOneWidget);

    // Verify that the Today and Next Monday buttons are rendered
    expect(find.byKey(const Key('today_button')), findsOneWidget);
    expect(find.byKey(const Key('next_monday_button')), findsOneWidget);
    expect(find.byKey(const Key('next_tuesday_button')), findsOneWidget);
    expect(find.byKey(const Key('after_1_week_button')), findsOneWidget);

    // Verify that the TableCalendar is rendered
    expect(find.byType(TableCalendar), findsOneWidget);

    // Tap on the Next Monday button
    await tester.tap(find.byKey(const Key('next_monday_button')));
    await tester.pump();
    // Verify that the next monday date text is updated
    expect(find.text(DateTime.now().nextMonday.dMMMYYYY), findsOneWidget);

    // Tap on the Next Tuesday button
    await tester.tap(find.byKey(const Key('next_tuesday_button')));
    await tester.pump();
    // Verify that the next tuesday date text is updated
    expect(find.text(DateTime.now().nextTuesday.dMMMYYYY), findsOneWidget);

    // Tap on the Next Week button
    await tester.tap(find.byKey(const Key('after_1_week_button')));
    await tester.pump();
    // Verify that the next week date text is updated
    expect(find.text(DateTime.now().nextWeek.dMMMYYYY), findsOneWidget);

    // // Tap on cancel button & verify that selected date is null;
    // await tester.tap(find.text('Cancel'));
    // await tester.pumpAndSettle();
    // expect(selectedDate, isNull);
    //
    // // again open the date picker
    // await _openDatePicker(tester);

    // Tap on the Today button
    await tester.tap(find.byKey(const Key('today_button')));
    await tester.pump();
    expect(find.text(DateTime.now().dMMMYYYY), findsOneWidget);

    // Tap on save button & verify that selected date is today's date
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(selectedDate?.isTodayDate, isTrue);

    // Verify that the selected date is updated
    expect(selectedDate, isNotNull);
  });
}

Future<void> _openDatePicker(WidgetTester tester) async {
  // Tap on the button to open the date picker
  await tester.tap(find.text('Open DatePicker'));
  await tester.pumpAndSettle();
}
