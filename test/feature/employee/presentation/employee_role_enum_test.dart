import 'package:employee_connect/feature/employee/presentation/employee_role_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmployeeRole enum tests', () {
    test('EmployeeRole.none should have id "0" and label ""', () {
      expect(EmployeeRole.none.id, '0');
      expect(EmployeeRole.none.label, '');
    });

    test('EmployeeRole.fromId should return correct role for valid id', () {
      final productDesigner = EmployeeRole.fromId('1');
      expect(productDesigner, EmployeeRole.productDesigner);

      final qATester = EmployeeRole.fromId('3');
      expect(qATester, EmployeeRole.qATester);
    });

    test('EmployeeRole.fromId should return EmployeeRole.none for invalid id', () {
      final role = EmployeeRole.fromId('invalid_id');
      expect(role, EmployeeRole.none);
    });

    test('EmployeeRole.forUi should return a list of roles for UI', () {
      final uiRoles = EmployeeRole.forUi;
      expect(uiRoles, contains(EmployeeRole.productDesigner));
      expect(uiRoles, contains(EmployeeRole.flutterDeveloper));
      expect(uiRoles, contains(EmployeeRole.qATester));
      expect(uiRoles, contains(EmployeeRole.productOwner));
    });
  });
}
