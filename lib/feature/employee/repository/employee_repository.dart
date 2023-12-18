import 'package:employee_connect/core/database/app_database.dart';
import 'package:employee_connect/feature/employee/models/employee.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> getAllEmployee();

  Future<int> addEmployee({required Employee employee});

  Future<bool> updateEmployee({required Employee employee});

  Future<int> deleteEmployee({required Employee employee});
}

class LocalEmployeeRepository implements EmployeeRepository {
  LocalEmployeeRepository({required AppDataBase appDataBase})
      : _appDataBase = appDataBase;

  final AppDataBase _appDataBase;

  @override
  Future<List<Employee>> getAllEmployee() async {
    final employees = await _appDataBase.getAllEmployees();
    return employees.map(Employee.fromEmployeeItemData).toList();
  }

  @override
  Future<int> addEmployee({required Employee employee}) {
    return _appDataBase.insertEmployee(employee.toEmployeeItemData);
  }

  @override
  Future<bool> updateEmployee({required Employee employee}) {
    return _appDataBase.updateEmployee(employee.toEmployeeItemData);
  }

  @override
  Future<int> deleteEmployee({required Employee employee}) {
    return _appDataBase.deleteEmployee(employee.toEmployeeItemData);
  }
}
