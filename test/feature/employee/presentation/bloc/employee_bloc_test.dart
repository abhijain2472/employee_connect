import 'package:bloc_test/bloc_test.dart';
import 'package:employee_connect/core/app_strings.dart';
import 'package:employee_connect/feature/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee_connect/feature/employee/repository/employee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../test_objects.dart';

void main() {
  late EmployeeRepository _employeeRepository;
  late EmployeeBloc _employeeBloc;
  setUp(() {
    _employeeRepository = MockEmployeeRepository();
    _employeeBloc = EmployeeBloc(
      employeeRepository: _employeeRepository,
    );
  });
  tearDown(() => _employeeBloc.close());

  group(
    'Employee Bloc Test',
    () {
      blocTest<EmployeeBloc, EmployeeState>(
        'emits [EmployeeLoading,EmployeeLoaded] state for success loading',
        build: () => _employeeBloc,
        act: (_) {
          when(() => _employeeRepository.getAllEmployee())
              .thenAnswer((invocation) async => tEmployeeList);
          _employeeBloc.add(LoadAllEmployees());
        },
        expect: () => [
          EmployeeLoading(),
          EmployeeLoaded(employees: tEmployeeList),
        ],
      );
      blocTest<EmployeeBloc, EmployeeState>(
        'emits [EmployeeLoading,EmployeeLoaded] state with added employee',
        build: () => _employeeBloc,
        act: (_) {
          when(() => _employeeRepository.addEmployee(employee: tEmployee1))
              .thenAnswer((invocation) async => 1);
          _employeeBloc.add(AddEmployee(employee: tEmployee1));
        },
        expect: () => [
          EmployeeLoading(),
          EmployeeLoaded(employees: [tEmployee1]),
        ],
      );

      blocTest<EmployeeBloc, EmployeeState>(
        'emits Error state for add employee exception',
        build: () => _employeeBloc,
        act: (_) {
          when(() => _employeeRepository.addEmployee(employee: tEmployee1))
              .thenAnswer(
            (invocation) async => throw Exception(AppStrings.commonErrorMsg),
          );
          _employeeBloc.add(AddEmployee(employee: tEmployee1));
        },
        expect: () => [
          isA<EmployeeLoading>(),
          isA<EmployeeError>(),
        ],
      );

      blocTest<EmployeeBloc, EmployeeState>(
        'emits [EmployeeLoading,EmployeeLoaded] state with delete employee',
        build: () => _employeeBloc,
        act: (_) {
          when(() => _employeeRepository.addEmployee(employee: tEmployee2))
              .thenAnswer((invocation) async => 1);
          when(() => _employeeRepository.deleteEmployee(employee: tEmployee2))
              .thenAnswer((invocation) async => 1);
          _employeeBloc.add(AddEmployee(employee: tEmployee2));
          _employeeBloc.add(DeleteEmployee(employee: tEmployee2));
        },
        expect: () => [
          EmployeeLoading(),
          EmployeeLoaded(employees: [tEmployee2]),
          EmployeeLoading(),
          const EmployeeLoaded(employees: []),
        ],
      );

      blocTest<EmployeeBloc, EmployeeState>(
        'emits proper state with value for update employee',
        build: () => _employeeBloc,
        act: (_) {
          when(() => _employeeRepository.addEmployee(employee: tEmployee2))
              .thenAnswer((invocation) async => 1);
          when(() => _employeeRepository.updateEmployee(
                  employee: updatedEmployee2))
              .thenAnswer((invocation) async => true);
          _employeeBloc.add(AddEmployee(employee: tEmployee2));
          _employeeBloc.add(UpdateEmployee(employee: updatedEmployee2));
        },
        expect: () => [
          EmployeeLoading(),
          EmployeeLoaded(employees: [tEmployee2]),
          EmployeeLoading(),
          EmployeeLoaded(employees: [updatedEmployee2]),
        ],
      );
      blocTest<EmployeeBloc, EmployeeState>(
        'emits [EmployeeLoading,EmployeeLoaded] state with undo delete employee',
        build: () => _employeeBloc,
        act: (_) {
          when(() => _employeeRepository.addEmployee(employee: tEmployee2))
              .thenAnswer((invocation) async => 1);
          when(() => _employeeRepository.deleteEmployee(employee: tEmployee2))
              .thenAnswer((invocation) async => 1);
          _employeeBloc.add(AddEmployee(employee: tEmployee2));
          _employeeBloc.add(DeleteEmployee(employee: tEmployee2));
          _employeeBloc.add(UndoDeleteEmployee());
        },
        expect: () => [
          EmployeeLoading(),
          EmployeeLoaded(employees: [tEmployee2]),
          EmployeeLoading(),
          const EmployeeLoaded(employees: []),
          EmployeeLoading(),
          EmployeeLoaded(employees: [tEmployee2]),
        ],
      );
    },
  );
}
