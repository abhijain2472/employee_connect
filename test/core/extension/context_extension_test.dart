import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  group(
    'MediaQuery Extension Test',
    () {
      testWidgets('should return non-null values for height, width, and size',
          (WidgetTester tester) async {
        late BuildContext mockContext;
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                mockContext = context;
                return Container();
              },
            ),
          ),
        );
        final height = mockContext.height;
        final width = mockContext.width;
        final size = mockContext.size;

        expect(height, isNotNull);
        expect(width, isNotNull);
        expect(size, isNotNull);

        expect(height, greaterThan(0.0));
        expect(width, greaterThan(0.0));
        expect(size, isNotNull);
      });
    },
  );

  group(
    'Theme Extension Test',
    () {
      testWidgets(
          'should return non-null values for appColors and appTextStyle',
          (WidgetTester tester) async {
        late BuildContext mockContext;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                mockContext = context;
                return Container();
              },
            ),
          ),
        );

        final appColors = mockContext.appColors;
        final appTextStyle = mockContext.appTextStyle;

        expect(appColors, isNotNull);
        expect(appTextStyle, isNotNull);
      });
    },
  );

  group(
    'Focus Extension Test',
    () {
      testWidgets('should focus and un-focus TextField without errors',
          (WidgetTester tester) async {
        final focusNode = FocusNode();
        await tester.pumpWidget(focusTestWidget(focusNode));
        await tester.pump();
        // Initial state: TextField is not focused
        expect(focusNode.hasPrimaryFocus, false);

        // Tap the button to focus the TextField
        await tester.tap(find.text('Focus TextField'));
        await tester.pump();

        // After tapping, TextField should be focused
        expect(focusNode.hasPrimaryFocus, true);

        // Tap outside the TextField to un-focus it
        await tester.tap(find.text('Outside Text')); // Tap the button again
        await tester.pump();

        // After tapping again, TextField should be unfocused
        expect(focusNode.hasPrimaryFocus, false);
      });

      testWidgets('should hide and show keyboard without errors',
          (WidgetTester tester) async {
        final focusNode = FocusNode();

        await tester.pumpWidget(focusTestWidget(focusNode));

        // Initial state: Keyboard is not visible
        expect(tester.testTextInput.isVisible, isFalse);

        // Tap the button to focus the TextField and show the keyboard
        await tester.tap(find.text('Focus TextField'));
        await tester.pump();

        // After tapping, Keyboard should be visible
        expect(tester.testTextInput.isVisible, isTrue);

        // Tap outside the TextField to un-focus it and hide the keyboard
        await tester.tap(find.text('Outside Text')); // Tap the button again
        await tester.pump();

        // After tapping again, Keyboard should be hidden
        expect(tester.testTextInput.isVisible, isFalse);
      });
    },
  );
}

Widget focusTestWidget(FocusNode focusNode) {
  return TestableWidget(
    child: Builder(
      builder: (context) {
        return Column(
          children: [
            TextField(focusNode: focusNode),
            ElevatedButton(
              onPressed: () => context.requestFocus(focusNode),
              child: const Text('Focus TextField'),
            ),
            ElevatedButton(
              onPressed: () => context.removeFocus(),
              child: const Text('Outside Text'),
            ),
          ],
        );
      },
    ),
  );
}
