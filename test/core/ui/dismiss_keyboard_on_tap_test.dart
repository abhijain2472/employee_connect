import 'package:employee_connect/core/ui/widgets/dismiss_keyboard_on_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  testWidgets('DismissKeyboardOnTap should dismiss keyboard on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TestableWidget(
        child: DismissKeyboardOnTap(
          child: Column(
            children: const [
              TextField(),
              Text('Outside Text'),
            ],
          ),
        ),
      ),
    );

    // Tap the TextField to bring up the keyboard.
    await tester.tap(find.byType(TextField));
    await tester.pump();

    // Verify that the keyboard is initially focused.
    expect(tester.testTextInput.isVisible, isTrue);

    // Tap the widget to dismiss the keyboard.
    await tester.tap(find.text('Outside Text'));
    await tester.pump();

    // Verify that the keyboard is dismissed.
    expect(tester.testTextInput.isVisible, isFalse);
  });
}
