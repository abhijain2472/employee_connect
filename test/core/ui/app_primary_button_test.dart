import 'package:employee_connect/core/ui/app_colors.dart';
import 'package:employee_connect/core/ui/sizing_util.dart';
import 'package:employee_connect/core/ui/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  group('AppPrimaryButton', () {
    testWidgets('should render correctly with provided title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestableWidget(
          child: AppPrimaryButton(
            onTap: () {},
            title: 'Test Button',
          ),
        ),
      );

      // Verify that the button is rendered with the correct title
      expect(find.text('Test Button'), findsOneWidget);

      // Verify that the button has the correct styling
      final buttonWidget = find.byType(AppPrimaryButton);
      expect(buttonWidget, findsOneWidget);

      final buttonContainer = tester.widget<Container>(find.byType(Container));
      expect(
        buttonContainer.decoration,
        BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppRounding.px6),
        ),
      );

      final buttonText = tester.widget<Text>(find.text('Test Button'));
      expect(buttonText.style?.color, AppColors.white);
    });

    testWidgets('should call onTap when the button is tapped',
        (WidgetTester tester) async {
      var tapped = false;
      void onTapMock() {
        tapped = true;
      }

      // Build our widget and trigger a frame
      await tester.pumpWidget(
          TestableWidget(
            child: AppPrimaryButton(
              onTap: onTapMock,
              title: 'Test Button',
            ),
          ),
      );

      await tester.tap(find.byType(InkWell));

      // Trigger a frame
      await tester.pump();

      // Verify that onTap is called when the button is tapped
      expect(tapped, isTrue);
    });
  });
}
