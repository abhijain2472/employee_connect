import 'package:employee_connect/core/database/app_database.dart';
import 'package:employee_connect/feature/employee/repository/employee_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockEmployeeRepository extends Mock implements EmployeeRepository {}

class MockAppDataBase extends Mock implements AppDataBase{}
