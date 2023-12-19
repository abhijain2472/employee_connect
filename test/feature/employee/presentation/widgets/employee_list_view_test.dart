import 'package:bloc_test/bloc_test.dart';
import 'package:employee_connect/feature/employee/models/employee.dart';
import 'package:employee_connect/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee_connect/feature/employee/presentation/widgets/employee_list_view.dart';
import 'package:employee_connect/feature/employee/presentation/widgets/employee_tile.dart';
import 'package:employee_connect/feature/employee/repository/employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employee_connect/core/ui/widgets/horizontal_divider.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../helper.dart';
import '../../../../mocks.dart';
import '../../../../test_objects.dart';

void main() {
  late EmployeeBloc mockEmployeeBloc;

  setUp(() {
    mockEmployeeBloc = MockEmployeeBloc();
  });

  testWidgets('EmployeeListWithLabel should render correctly',
      (WidgetTester tester) async {
    whenListen(
      mockEmployeeBloc,
      Stream.fromIterable(
        [EmployeeLoading(), const EmployeeLoaded(employees: [])],
      ),
    );
    await tester.pumpWidget(
      BlocProvider<EmployeeBloc>.value(
        value: mockEmployeeBloc,
        child: TestableWidget(
          child: EmployeeListWithLabel(
            employees: tEmployeeList,
            label: 'Current Employees',
          ),
        ),
      ),
    );

    // Verify that the EmployeeListWithLabel is rendered
    expect(find.byType(EmployeeListWithLabel), findsOneWidget);

    // Verify the content of the EmployeeListWithLabel
    expect(find.text('Current Employees'), findsOneWidget);

    // Verify that the EmployeeTile is rendered for each employee
    for (final employee in tEmployeeList) {
      final employeeTile = find.byKey(Key('e$employee.employeeId'));
      expect(employeeTile, findsOneWidget);

      // Simulate a tap on the EmployeeTile
      // await tester.drag(employeeTile, const Offset(-500, 0));
      // await tester.pump();

      // Verify that the onTap callback is called with the correct employee
      // verify(() => mockEmployeeBloc.add(DeleteEmployee(employee: employee)))
      //     .called(1);
    }

    // Verify that HorizontalDivider is rendered between EmployeeTiles
    expect(find.byType(HorizontalDivider),
        findsNWidgets(tEmployeeList.length - 1));
  });
}
