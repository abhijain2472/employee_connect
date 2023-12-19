import 'package:employee_connect/core/ui/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  testWidgets(
    'Space should render correctly with height',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestableWidget(
          child: Space.vertical(5),
        ),
      );

      // Verify that the spacing is rendered.
      final spacing = find.byType(SizedBox);
      expect(spacing, findsOneWidget);

      // Verify that the spacing has the correct dimensions.
      final sizeBox = tester.widget<SizedBox>(spacing);
      expect(sizeBox.height, 5);
      expect(sizeBox.width, 0);
    },
  );

  testWidgets(
    'Space should render correctly with width',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestableWidget(
          child: Space.horizontal(5),
        ),
      );

      // Verify that the spacing is rendered.
      final spacing = find.byType(Space);
      expect(spacing, findsOneWidget);

      // Verify that the spacing has the correct dimensions.
      final sizeBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizeBox.width, 5);
      expect(sizeBox.height, 0);
    },
  );
}
