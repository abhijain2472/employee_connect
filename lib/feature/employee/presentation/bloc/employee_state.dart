part of 'employee_bloc.dart';

enum EmployeeLoadedType {
  none,
  add,
  update,
  delete,
}

abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

class EmployeeInitial extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeLoading extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeError extends EmployeeState {
  final String error;

  const EmployeeError({this.error = AppStrings.commonErrorMsg});

  @override
  List<Object> get props => [];
}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;

  final EmployeeLoadedType type;

  const EmployeeLoaded({
    required this.employees,
    this.type = EmployeeLoadedType.none,
  });

  @override
  List<Object> get props => [];

  bool get hasData => employees.isNotEmpty;

  bool get hasCurrentEmployee => currentEmployees.isNotEmpty;

  bool get hasPreviousEmployee => previousEmployees.isNotEmpty;

  List<Employee> get currentEmployees =>
      employees.where((emp) => emp.isCurrentEmployee).toList();

  List<Employee> get previousEmployees =>
      employees.where((emp) => !emp.isCurrentEmployee).toList();
}
