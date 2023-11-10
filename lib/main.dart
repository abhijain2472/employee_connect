import 'package:employee_connect/core/database/app_database.dart';
import 'package:employee_connect/core/dependency_injection.dart';
import 'package:employee_connect/core/ui/app_theme_data.dart';
import 'package:employee_connect/core/ui/widgets/dismiss_keyboard_on_tap.dart';
import 'package:employee_connect/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee_connect/feature/employee/repository/employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'core/app_strings.dart';
import 'feature/employee/presentation/pages/employee_home_page.dart';

void main() async {
  await setUpDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeBloc>(
      create: (context) => EmployeeBloc(
        employeeRepository: GetIt.I(),
      )..add(LoadAllEmployees()),
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
    );
  }
}
