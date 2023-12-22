import 'package:employee_connect/core/app_strings.dart';
import 'package:employee_connect/core/ui/widget_keys.dart';
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
    when(() => employeeRepository.updateEmployee(
            employee: any<Employee>(named: 'employee')))
        .thenAnswer((invocation) async => true);
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
    expect(find.byKey(WidgetKeys.employeeKey(firstEmployee.employeeId)),
        findsOneWidget);
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

    // verify another employee data

    //verify that interaction is called
    final captured2 = verify(() => employeeRepository.addEmployee(
        employee: captureAny(named: 'employee'))).captured;
    final secondEmployee = captured2.last as Employee;

    //verify that employee tile is visible with correct data
    expect(find.byKey(WidgetKeys.employeeKey(secondEmployee.employeeId)),
        findsOneWidget);
    expect(find.text(secondEmployee.name), findsOneWidget);
    // expect(find.text(secondEmployee.durationText), findsOneWidget);

    //verify that only current employee label is visible
    expect(find.text(AppStrings.currentEmployeesLabel), findsOneWidget);
    expect(find.text(AppStrings.previousEmployeesLabel), findsOneWidget);
    expect(find.byType(EmployeeTile), findsNWidgets(2));

    //verify the update employee flow
    await _verifyUpdateEmployeeFlow(
      tester: tester,
      firstEmployee: firstEmployee,
      employeeRepository: employeeRepository,
    );

    await _verifyDeleteEmployeeFlow(
      tester: tester,
      firstEmployee: firstEmployee,
      employeeRepository: employeeRepository,
    );
  });
}

Future<void> _verifyDeleteEmployeeFlow({
  required WidgetTester tester,
  required Employee firstEmployee,
  required EmployeeRepository employeeRepository,
}) async {
  final employeeTile =
      find.byKey(WidgetKeys.employeeKey(firstEmployee.employeeId));
  await tester.drag(employeeTile, const Offset(-500, 0));
  await tester.pumpAndSettle();

  final captured = verify(() => employeeRepository.deleteEmployee(
      employee: captureAny(named: 'employee'))).captured;
  final deletedEmp = captured.last as Employee;
  expect(firstEmployee.employeeId, deletedEmp.employeeId);

  //verify that now employee tile is not visible
  expect(employeeTile, findsNothing);
  expect(find.text(AppStrings.currentEmployeesLabel), findsNothing);

  //verify that snack bar is visible
  expect(find.byType(SnackBar), findsOneWidget);
  expect(find.text(AppStrings.deleteEmployeeMsg), findsOneWidget);
  expect(find.byType(SnackBarAction), findsOneWidget);

  // verify the undo delete flow
  await tester.tap(find.text(AppStrings.undo));

  verify(() => employeeRepository.addEmployee(
      employee: any<Employee>(named: 'employee')));
  await tester.pumpAndSettle();

  expect(employeeTile, findsOneWidget);
  expect(find.text(AppStrings.currentEmployeesLabel), findsOneWidget);
}

Future<void> _verifyUpdateEmployeeFlow({
  required WidgetTester tester,
  required Employee firstEmployee,
  required EmployeeRepository employeeRepository,
}) async {
  await tester
      .tap(find.byKey(WidgetKeys.employeeKey(firstEmployee.employeeId)));
  await tester.pumpAndSettle();

  //verify the app bar title & delete icon visibility
  expect(find.text(AppStrings.updateEmployeeAppBarTitle), findsOneWidget);
  expect(find.byKey(WidgetKeys.deleteEmpIcon), findsOneWidget);

  // Update employee name
  await tester.enterText(
      find.byKey(WidgetKeys.nameInput), updatedEmployee1.name);

  // Save the employee
  await tester.tap(find.byKey(WidgetKeys.empSave));
  await tester.pumpAndSettle();

  // verify navigation back to home screen
  expect(find.text(AppStrings.homePageAppBarTitle), findsOneWidget);
  verify(() => employeeRepository.updateEmployee(
      employee: captureAny(named: 'employee')));

  //verify old name is replaced by new updated name;
  expect(find.text(firstEmployee.name), findsNothing);
  expect(find.text(updatedEmployee1.name), findsOneWidget);
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
  await tester.enterText(find.byKey(WidgetKeys.nameInput), employee.name);
  await tester
      .tap(find.byKey(WidgetKeys.roleInput)); // Tap on the role text field
  await tester.pumpAndSettle();

  // Select a role from the bottom sheet
  await tester.tap(find.text(employee.employeeRole.label));
  await tester.pumpAndSettle();

  //verify that role selected label is visible in text field;
  expect(find.text(employee.employeeRole.label), findsOneWidget);
  if (!employee.isCurrentEmployee) {
    // select the end date
    await tester.tap(find.byKey(WidgetKeys.endDateInput));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(WidgetKeys.dateSave));
    await tester.pumpAndSettle();
  }

  // Save the employee
  await tester.tap(find.byKey(WidgetKeys.empSave));
  await tester.pumpAndSettle();
}
