import 'package:employee_connect/feature/employee/presentation/widgets/employee_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../helper.dart';
import '../../../../test_objects.dart';

void main() {
  group('Employee Tile Test', () {
    testWidgets('EmployeeTile should render correctly',
        (WidgetTester tester) async {
      // Mock callbacks
      bool onDeleteCalled = false;
      bool onTapCalled = false;

      await tester.pumpWidget(
        TestableWidget(
          child: EmployeeTile(
            employee: tEmployee1,
            onDelete: () {
              onDeleteCalled = true;
            },
            onTap: () {
              onTapCalled = true;
            },
          ),
        ),
      );

      // Verify that the EmployeeTile is rendered
      expect(find.byType(EmployeeTile), findsOneWidget);

      // Verify that the delete background is not shown initially
      expect(find.byType(DeleteView), findsNothing);

      // Verify the content of the EmployeeTile
      expect(find.text(tEmployee1.name), findsOneWidget);
      expect(find.text(tEmployee1.employeeRole.label), findsOneWidget);

      // Simulate tap on the EmployeeTile
      await tester.tap(find.byType(EmployeeTile));
      await tester.pump();

      // Verify that onTap callback is called
      expect(onTapCalled, isTrue);

      // Simulate swipe to delete
      await tester.drag(find.byType(EmployeeTile), const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      // Verify that the delete background is shown
      expect(find.byType(DeleteView), findsOneWidget);

      // Verify that onDelete callback is called
      expect(onDeleteCalled, isTrue);
    });
  });
}
