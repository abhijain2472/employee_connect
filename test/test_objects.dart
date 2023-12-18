import 'package:employee_connect/core/database/app_database.dart';
import 'package:employee_connect/feature/employee/models/employee.dart';
import 'package:employee_connect/feature/employee/presentation/employee_role_enum.dart';

final tEmployee1 = Employee(
  employeeId: '1',
  name: 'First Employee',
  roleId: EmployeeRole.flutterDeveloper.id,
  startDate: '2023-12-10 00:00:00.000Z',
);

final tEmployee2 = Employee(
  employeeId: '2',
  name: 'Second Employee',
  roleId: EmployeeRole.productOwner.id,
  startDate: '2023-12-10 00:00:00.000Z',
  endDate: '2023-12-14 00:00:00.000Z',
);

final tEmployee3 = Employee(
  employeeId: '3',
  name: 'Third Employee',
  roleId: EmployeeRole.productDesigner.id,
  startDate: '2023-12-02 00:00:00.000Z',
);

final tEmployee4 = Employee(
  employeeId: '4',
  name: 'Fourth Employee',
  roleId: EmployeeRole.qATester.id,
  startDate: '2023-12-11 00:00:00.000Z',
  endDate: '2023-12-20 00:00:00.000Z',
);

final tEmpItemData1 = EmployeeItemData(
  employeeId: '1',
  name: 'First Employee',
  roleId: EmployeeRole.flutterDeveloper.id,
  startDate: '2023-12-10 00:00:00.000Z',
  endDate: '',
);

final tEmpItemData2 = EmployeeItemData(
  employeeId: '2',
  name: 'Second Employee',
  roleId: EmployeeRole.productOwner.id,
  startDate: '2023-12-10 00:00:00.000Z',
  endDate: '2023-12-14 00:00:00.000Z',
);

final tEmpItemData3 = EmployeeItemData(
  employeeId: '3',
  name: 'Third Employee',
  roleId: EmployeeRole.productDesigner.id,
  startDate: '2023-12-02 00:00:00.000Z',
  endDate: '',
);

final tEmpItemData4 = EmployeeItemData(
  employeeId: '4',
  name: 'Fourth Employee',
  roleId: EmployeeRole.qATester.id,
  startDate: '2023-12-11 00:00:00.000Z',
  endDate: '2023-12-20 00:00:00.000Z',
);
final updatedEmployee2 = tEmployee2.copyWith(name: 'Updated Name');

final tEmployeeList = <Employee>[
  tEmployee1,
  tEmployee2,
  tEmployee3,
  tEmployee4,
];
final tEmployeeItemDataList = <EmployeeItemData>[
  tEmpItemData1,
  tEmpItemData2,
  tEmpItemData3,
  tEmpItemData4,
];

final tDate = DateTime(2023, 1, 15);
const tDateString = '2023-01-15';

