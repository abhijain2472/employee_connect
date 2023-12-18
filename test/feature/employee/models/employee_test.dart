import 'package:employee_connect/feature/employee/models/employee.dart';
import 'package:employee_connect/feature/employee/presentation/employee_role_enum.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_objects.dart';

void main() {
  group('Employee Model Test', () {
    test(
      'Should create proper object from constructor',
      () {
        final result = Employee(
          employeeId: '1',
          name: 'First Employee',
          roleId: EmployeeRole.flutterDeveloper.id,
          startDate: '2023-12-10 00:00:00.000Z',
        );
        expect(result, tEmployee1);
      },
    );

    test(
      'Should return correct Employee model from fromEmployeeItemData method',
      () {
        final result = Employee.fromEmployeeItemData(tEmpItemData1);
        expect(result, tEmployee1);
      },
    );
    test(
      'Should convert correct EmployeeItemData from toEmployeeItemData getter',
      () {
        final result = tEmployee2.toEmployeeItemData;
        expect(result, tEmpItemData2);
      },
    );
    test(
      'Should return correct Employee Role from getter',
      () {
        final result = tEmployee1.employeeRole;
        expect(result, EmployeeRole.flutterDeveloper);
      },
    );
    test(
      'Should return true from current employee getter if end date is empty',
      () {
        final result = tEmployee1.isCurrentEmployee;
        expect(result, true);
      },
    );
    test(
      'Should create a copy with updated value',
      () {
        final result = tEmployee2.copyWith(name: 'Updated', employeeId: '3');
        expect(result.name, 'Updated'); //name should be changed
        expect(result.employeeId, '3'); //employeeId should be changed
        expect(result.roleId, '4'); // roleId should remain unchanged
      },
    );

    test(
      'Should create an identical copy when no values are provided',
      () {
        final result = tEmployee2.copyWith();
        expect(result, tEmployee2);
      },
    );
    test(
      'Should return proper text for duration',
      () {
        final duration1 = tEmployee1.durationText;
        final duration2 = tEmployee2.durationText;
        expect(duration1, 'From 10 Dec, 2023');
        expect(duration2, '10 Dec, 2023 - 14 Dec, 2023');
      },
    );
  });
}
