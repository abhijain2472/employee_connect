part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class LoadAllEmployees extends EmployeeEvent {
  @override
  List<Object?> get props => [];
}

class AddEmployee extends EmployeeEvent {
  final Employee employee;

  const AddEmployee({
    required this.employee,
  });

  @override
  List<Object> get props => [employee];
}

class UpdateEmployee extends EmployeeEvent {
  final Employee employee;

  const UpdateEmployee({
    required this.employee,
  });

  @override
  List<Object> get props => [employee];
}

class DeleteEmployee extends EmployeeEvent {
  final Employee employee;

  const DeleteEmployee({
    required this.employee,
  });

  @override
  List<Object> get props => [employee];
}

class UndoDeleteEmployee extends EmployeeEvent {
  @override
  List<Object> get props => [];
}
