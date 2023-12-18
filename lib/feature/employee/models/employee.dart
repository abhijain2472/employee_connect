import 'package:employee_connect/core/extension/date_extensions.dart';
import 'package:equatable/equatable.dart';

import '../../../core/database/app_database.dart';
import '../presentation/employee_role_enum.dart';

class Employee extends Equatable {
  final String employeeId;
  final String name;
  final String roleId;
  final String startDate;
  final String endDate;

  const Employee({
    required this.employeeId,
    required this.name,
    required this.roleId,
    required this.startDate,
    this.endDate = '',
  });

  factory Employee.fromEmployeeItemData(EmployeeItemData employeeItemData) {
    return Employee(
      employeeId: employeeItemData.employeeId,
      name: employeeItemData.name,
      roleId: employeeItemData.roleId,
      startDate: employeeItemData.startDate,
      endDate: employeeItemData.endDate,
    );
  }

  Employee copyWith({
    String? employeeId,
    String? name,
    String? roleId,
    String? startDate,
    String? endDate,
  }) {
    return Employee(
      employeeId: employeeId ?? this.employeeId,
      name: name ?? this.name,
      roleId: roleId ?? this.roleId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  EmployeeItemData get toEmployeeItemData => EmployeeItemData(
        employeeId: employeeId,
        name: name,
        roleId: roleId,
        startDate: startDate,
        endDate: endDate,
      );

  @override
  List<Object?> get props => [employeeId, startDate, endDate];

  EmployeeRole get employeeRole => EmployeeRole.fromId(roleId);

  bool get isCurrentEmployee => endDate.trim().isEmpty;

  String get durationText {
    final start = startDate.toDateTimeN;
    final end = endDate.toDateTimeN;
    if (start != null && end != null) {
      return '${start.dMMMYYYY} - ${end.dMMMYYYY}';
    } else if (start != null) {
      return 'From ${start.dMMMYYYY}';
    }
    return '';
  }
}
