import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:employee_connect/core/ui/sizing_util.dart';
import 'package:employee_connect/core/ui/widgets/app_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  group('AppSecondaryButton Test', () {
    testWidgets('should render correctly with provided title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(
          child: AppSecondaryButton(
            onTap: () {},
            title: 'Test Button',
          ),
        ),
      );

      // Verify that the button is rendered with the correct title
      expect(find.text('Test Button'), findsOneWidget);

      // Verify that the button has the correct styling
      final buttonWidget = find.byType(AppSecondaryButton);
      expect(buttonWidget, findsOneWidget);

      final buttonContainer = tester.widget<Container>(find.byType(Container));
      expect(
        buttonContainer.decoration,
        BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(AppRounding.px6),
        ),
      );

      final buttonText = tester.widget<Text>(find.text('Test Button'));
      expect(buttonText.style?.color, AppColors.primary);
    });

    testWidgets('should call onTap when the button is tapped',
        (WidgetTester tester) async {
      // Create a mock function to track onTap calls
      var tapped = false;
      void onTapMock() {
        tapped = true;
      }

      // Build our widget and trigger a frame
      await tester.pumpWidget(
        TestableWidget(
          child: AppSecondaryButton(
            onTap: onTapMock,
            title: 'Test Button',
          ),
        ),
      );

      // Tap the button
      await tester.tap(find.byType(InkWell));

      // Trigger a frame
      await tester.pump();

      // Verify that onTap is called when the button is tapped
      expect(tapped, isTrue);
    });
  });
}
