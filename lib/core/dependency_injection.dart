import 'package:employee_connect/feature/employee/repository/employee_repository.dart';
import 'package:get_it/get_it.dart';

import 'database/app_database.dart';

Future<void> setUpDependency() async{
  if (!GetIt.I.isRegistered<AppDataBase>()) {
    GetIt.I.registerLazySingleton<AppDataBase>(AppDataBase.new);
  }
  if (!GetIt.I.isRegistered<EmployeeRepository>()) {
    GetIt.I.registerLazySingleton<EmployeeRepository>(
      () => LocalEmployeeRepository(appDataBase: GetIt.I.get()),
    );
  }
}
