import 'package:employee_connect/core/app_strings.dart';
import 'package:employee_connect/core/ui/widgets/dismiss_keyboard_on_tap.dart';
import 'package:employee_connect/feature/employee/models/employee.dart';
import 'package:employee_connect/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee_connect/feature/employee/presentation/pages/employee_home_page.dart';
import 'package:employee_connect/feature/employee/presentation/widgets/employee_tile.dart';
import 'package:employee_connect/feature/employee/presentation/widgets/empty_state_view.dart';
import 'package:employee_connect/feature/employee/repository/employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../test/mocks.dart';
import '../test/test_objects.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late EmployeeRepository employeeRepository;
  late EmployeeBloc employeeBloc;
  setUp(() {
    registerFallbackValue(MockEmployee());
    employeeRepository = MockEmployeeRepository();
    employeeBloc = EmployeeBloc(
      employeeRepository: employeeRepository,
    );
  });
  tearDown(() => employeeBloc.close());

  testWidgets('Test employee add and delete flow', (WidgetTester tester) async {
    // arrange
    when(() => employeeRepository.getAllEmployee())
        .thenAnswer((invocation) async => []);
    when(() => employeeRepository.addEmployee(
            employee: any<Employee>(named: 'employee')))
        .thenAnswer((invocation) async => 1);
    when(() => employeeRepository.deleteEmployee(
            employee: any<Employee>(named: 'employee')))
        .thenAnswer((invocation) async => 1);

    // act
    await tester.pumpWidget(
      BlocProvider<EmployeeBloc>(
        create: (context) => employeeBloc..add(LoadAllEmployees()),
        child: Builder(
          builder: (context) {
            return const DismissKeyboardOnTap(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: AppStrings.appTitle,
                // theme: AppThemeData.lightThemeData(context),
                home: EmployeeHomePage(),
              ),
            );
          },
        ),
      ),
    );

    // Wait for the app to load
    await tester.pumpAndSettle();

    // initially there is empty state
    expect(find.byType(EmptyStateView), findsOneWidget);

    await _addEmployee(
      tester: tester,
      employee: tEmployee1,
    );

    //verify that interaction is called
    final captured = verify(() => employeeRepository.addEmployee(
        employee: captureAny(named: 'employee'))).captured;
    final firstEmployee = captured.last as Employee;

    //verify that empty state view is not visible now
    expect(find.byType(EmptyStateView), findsNothing);

    //verify that employee tile is visible with correct data
    expect(find.byKey(Key('e${firstEmployee.employeeId}')), findsOneWidget);
    expect(find.text(firstEmployee.name), findsOneWidget);
    expect(find.text(firstEmployee.durationText), findsOneWidget);

    //verify that only current employee label is visible
    expect(find.text(AppStrings.currentEmployeesLabel), findsOneWidget);
    expect(find.text(AppStrings.previousEmployeesLabel), findsNothing);

    // add another employee
    await _addEmployee(
      tester: tester,
      employee: tEmployee2,
    );

    //verify that interaction is called
    final captured2 = verify(() => employeeRepository.addEmployee(
        employee: captureAny(named: 'employee'))).captured;
    final secondEmployee = captured2.last as Employee;

    //verify that employee tile is visible with correct data
    expect(find.byKey(Key('e${secondEmployee.employeeId}')), findsOneWidget);
    expect(find.text(secondEmployee.name), findsOneWidget);
    // expect(find.text(secondEmployee.durationText), findsOneWidget);

    //verify that only current employee label is visible
    expect(find.text(AppStrings.currentEmployeesLabel), findsOneWidget);
    expect(find.text(AppStrings.previousEmployeesLabel), findsOneWidget);

    expect(find.byType(EmployeeTile), findsNWidgets(2));
  });
}

Future<void> _addEmployee({
  required WidgetTester tester,
  required Employee employee,
}) async {
  // Find and tap the add button
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();

  // add employee page visible
  expect(find.text(AppStrings.addEmployeeAppBarTitle), findsOneWidget);

   // Enter employee details and save
  await tester.enterText(
      find.byKey(const Key(AppStrings.nameHintText)), employee.name);
  await tester.tap(find
      .byKey(const Key(AppStrings.roleHintText))); // Tap on the role text field
  await tester.pumpAndSettle();

  // Select a role from the bottom sheet
  await tester.tap(find.text(employee.employeeRole.label));
  await tester.pumpAndSettle();

  //verify that role selected label is visible in text field;
  expect(find.text(employee.employeeRole.label), findsOneWidget);
  if (!employee.isCurrentEmployee) {
    // select the end date
    await tester.tap(find.byKey(const Key(AppStrings.endDateHintText)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('date-save')));
    await tester.pumpAndSettle();

  }

  // Save the employee
  await tester.tap(find.text(AppStrings.saveCTAText));
  await tester.pumpAndSettle();
}
