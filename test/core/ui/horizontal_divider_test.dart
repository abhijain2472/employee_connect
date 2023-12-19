import 'package:employee_connect/core/ui/widgets/horizontal_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employee_connect/core/ui/app_colors.dart';

import '../../helper.dart';

void main() {
  testWidgets('HorizontalDivider should render correctly with default color',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestableWidget(
        child: HorizontalDivider(),
      ),
    );

    // Verify that the divider is rendered.
    final divider = find.byType(HorizontalDivider);
    expect(divider, findsOneWidget);

    // Verify that the divider has the default color.
    final container = tester.widget<Container>(find.byType(Container));
    expect(container.color, AppColors.dividerColor);

    // Verify that the divider has the correct dimensions.
    final dividerBox = tester.getRect(divider);
    expect(dividerBox.height, 1.0);
  });

  testWidgets('HorizontalDivider should render correctly with custom color',
      (WidgetTester tester) async {
    // Build our widget with a custom color and trigger a frame.
    await tester.pumpWidget(
      const TestableWidget(
        child: HorizontalDivider(
          color: Colors.red,
        ),
      ),
    );

    // Verify that the divider has the custom color.
    final container = tester.widget<Container>(find.byType(Container));
    expect(container.color, Colors.red);
  });
}
