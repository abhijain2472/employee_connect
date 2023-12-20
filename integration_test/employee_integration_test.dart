import 'package:employee_connect/core/app_strings.dart';
import 'package:employee_connect/core/ui/app_theme_data.dart';
import 'package:employee_connect/core/ui/widgets/dismiss_keyboard_on_tap.dart';
import 'package:employee_connect/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee_connect/feature/employee/presentation/pages/employee_home_page.dart';
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

  late EmployeeRepository _employeeRepository;
  late EmployeeBloc _employeeBloc;
  setUp(() {
    registerFallbackValue(MockEmployee());
    _employeeRepository = MockEmployeeRepository();
    _employeeBloc = EmployeeBloc(
      employeeRepository: _employeeRepository,
    );
  });
  tearDown(() => _employeeBloc.close());

  testWidgets('Test employee add and delete flow', (WidgetTester tester) async {
    // when(() => _employeeRepository.addEmployee(employee: any<Employee>()))
    //     .thenAnswer((invocation) async => 1);

    await tester.pumpWidget(
      BlocProvider<EmployeeBloc>(
        create: (context) => _employeeBloc,
        child: Builder(
          builder: (context) {
            return DismissKeyboardOnTap(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: AppStrings.appTitle,
                theme: AppThemeData.lightThemeData(context),
                home: const EmployeeHomePage(),
              ),
            );
          },
        ),
      ),
    );

    // Wait for the app to load
    await tester.pumpAndSettle();

    // initially there is empty state
    // expect(find.byType(EmptyStateView), findsOneWidget);

    // Find and tap the add button
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // add employee page visible
    expect(find.text(AppStrings.addEmployeeAppBarTitle), findsOneWidget);

    // // Enter employee details and save
    await tester.enterText(
        find.byKey(const Key(AppStrings.nameHintText)), tEmployee1.name);
    await tester.tap(find.byKey(
        const Key(AppStrings.roleHintText))); // Tap on the role text field
    await tester.pumpAndSettle();

    // Select a role from the bottom sheet
    await tester.tap(find.text(tEmployee1.employeeRole.label));
    await tester.pumpAndSettle();

    //verify that role selected label is visible in text field;

    expect(find.text(tEmployee1.employeeRole.label), findsOneWidget);

    // // Save the employee
    // await tester.tap(find.text('Save'));
    // await tester.pumpAndSettle();

  });
}
