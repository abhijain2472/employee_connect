import 'package:employee_connect/core/extension/context_extension.dart';
import 'package:employee_connect/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';
import '../../mocks.dart';

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

  group(
    'Toast Extension Test',
    () {
      testWidgets('should show and hide SnackBar with action without errors',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          TestableWidget(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    context.showSnackBar('Test SnackBar',
                        ctaText: 'Test Action');
                  },
                  child: const Text('Show SnackBar'),
                );
              },
            ),
          ),
        );

        // Initially there is no SnackBar
        expect(find.byType(SnackBar), findsNothing);

        // Tap the button to show the SnackBar
        await tester.tap(find.text('Show SnackBar'));
        await tester.pump();

        // Wait for the SnackBar to be displayed
        await tester.pump(const Duration(seconds: 1));

        // Check if the SnackBar is visible
        expect(find.byType(SnackBar), findsOneWidget);
        // Check if the SnackBar Action is visible
        expect(find.byType(SnackBarAction), findsOneWidget);

        // Wait for the SnackBar to hide (duration + delay)
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Check if the SnackBar is no longer visible
        expect(find.byType(SnackBar), findsNothing);
      });
    },
  );
  group(
    'Block Extension Test',
    () {
      testWidgets('should read bloc without errors',
          (WidgetTester tester) async {
        // Create a MaterialApp with a BlocProvider wrapping employee BLoC
        await tester.pumpWidget(
          TestableWidget(
            child: BlocProvider<EmployeeBloc>(
              create: (context) => EmployeeBloc(
                employeeRepository: MockEmployeeRepository(),
              ),
              child: Builder(
                builder: (context) {
                  // Access the BLoC using the BlockExtension
                  final bloc = context.readBloc<EmployeeBloc>();

                  // Verify that the BLoC is not null
                  expect(bloc, isNotNull);

                  return Container();
                },
              ),
            ),
          ),
        );
      });

      // Add more test cases for other scenarios if needed
    },
  );
  group('Navigator Extension Test', () {
    late BuildContext mockContext;
    testWidgets('should push and pop a page without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              mockContext = context;
              return const Text('Go to Second Page');
            },
          ),
        ),
      );

      // Tap the button to navigate to the second page
      await tester.tap(find.text('Go to Second Page'));
      await tester.pump();

       mockContext.push(const SecondPage());
      await tester.pumpAndSettle();

      // Verify that the second page is pushed onto the navigation stack
      expect(find.text('Second Page'), findsOneWidget);

      // Use the NavigatorExtension to pop the second page
      mockContext.pop();
      await tester.pumpAndSettle();

      // Verify that we are back to the first page
      expect(find.text('Go to Second Page'), findsOneWidget);
    });
  });
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

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Second Page')),
    );
  }
}
