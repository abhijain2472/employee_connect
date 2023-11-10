import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';
part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    },
  );
}

@DriftDatabase(
  tables: [EmployeeItem],
)
class AppDataBase extends _$AppDataBase {
  AppDataBase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //READ EMPLOYEE
  Future<List<EmployeeItemData>> getAllEmployees() => select(employeeItem).get();

  //INSERT EMPLOYEE
  Future<int> insertEmployee(EmployeeItemData employee) => into(employeeItem).insert(employee);

  //UPDATE EMPLOYEE
  Future<bool> updateEmployee(EmployeeItemData employee) => update(employeeItem).replace(employee);

  //DELETE EMPLOYEE
  Future<int> deleteEmployee(EmployeeItemData employee) => delete(employeeItem).delete(employee);

  // DELETE ALL EMPLOYEE
  Future<void> clearAllData() => delete(employeeItem).go();
}
