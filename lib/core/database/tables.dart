import 'package:drift/drift.dart';


class EmployeeItem extends Table  {
  TextColumn get employeeId => text()();
  TextColumn get name => text()();

  TextColumn get roleId => text()();

  TextColumn get startDate => text()();
  TextColumn get endDate => text()();

  @override
  Set<Column> get primaryKey => {employeeId};
}
