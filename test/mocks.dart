import 'package:bloc_test/bloc_test.dart';
import 'package:employee_connect/core/database/app_database.dart';
import 'package:employee_connect/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee_connect/feature/employee/repository/employee_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockEmployeeRepository extends Mock implements EmployeeRepository {}

class MockAppDataBase extends Mock implements AppDataBase {}

class MockEmployeeBloc extends MockBloc<EmployeeEvent, EmployeeState>
    implements EmployeeBloc {}
