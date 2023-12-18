import 'package:employee_connect/core/database/app_database.dart';
import 'package:employee_connect/feature/employee/models/employee.dart';
import 'package:employee_connect/feature/employee/repository/employee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../mocks.dart';
import '../../../test_objects.dart';

void main() {
  late AppDataBase mockAppDataBase;
  late EmployeeRepository employeeRepository;

  setUp(() {
    mockAppDataBase = MockAppDataBase();
    employeeRepository =
        LocalEmployeeRepository(appDataBase: mockAppDataBase);
  });

  group(
    'Employee Repository Test',
    () {
      test(
        'should call getAllEmployee of app database when called from repository',
        () async {
          when<dynamic>(() => mockAppDataBase.getAllEmployees()).thenAnswer(
            (invocation) async => tEmployeeItemDataList,
          );
          await employeeRepository.getAllEmployee();
          verify(() => mockAppDataBase.getAllEmployees());
          verifyNoMoreInteractions(mockAppDataBase);
        },
      );

      test(
        'should return List of employee from repository',
        () async {
          when<dynamic>(() => mockAppDataBase.getAllEmployees()).thenAnswer(
            (invocation) async => tEmployeeItemDataList,
          );
          final result = await employeeRepository.getAllEmployee();
          expect(result, isA<List<Employee>>());
          expect(result.length, tEmployeeItemDataList.length);
        },
      );

      test(
        'should return proper response for add employee',
        () async {
          when(() => mockAppDataBase.insertEmployee(tEmpItemData1)).thenAnswer(
            (invocation) async => 1,
          );
          final result =
              await employeeRepository.addEmployee(employee: tEmployee1);
          verify(() => mockAppDataBase.insertEmployee(tEmpItemData1));
          expect(result, 1);
          verifyNoMoreInteractions(mockAppDataBase);

        },
      );

      test(
        'should return proper response for delete employee',
        () async {
          when(() => mockAppDataBase.deleteEmployee(tEmpItemData1)).thenAnswer(
            (invocation) async => 1,
          );
          final result =
              await employeeRepository.deleteEmployee(employee: tEmployee1);
          verify(() => mockAppDataBase.deleteEmployee(tEmpItemData1));
          expect(result, 1);
          verifyNoMoreInteractions(mockAppDataBase);

        },
      );
      test(
        'should return proper response for update employee',
        () async {
          when(() => mockAppDataBase.updateEmployee(tEmpItemData1)).thenAnswer(
            (invocation) async => true,
          );
          final result =
              await employeeRepository.updateEmployee(employee: tEmployee1);
          verify(() => mockAppDataBase.updateEmployee(tEmpItemData1));
          expect(result, true);
          verifyNoMoreInteractions(mockAppDataBase);
        },
      );
    },
  );
}
