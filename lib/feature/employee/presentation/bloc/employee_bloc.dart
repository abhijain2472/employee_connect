import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:employee_connect/core/app_strings.dart';
import 'package:employee_connect/feature/employee/models/employee.dart';
import 'package:employee_connect/feature/employee/repository/employee_repository.dart';
import 'package:equatable/equatable.dart';

part 'employee_event.dart';

part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepository;

  final _allEmployees = <Employee>[];

  Employee? lastDeletedEmployee;
  int? lastDeletedIndex;

  List<Employee> get employees => _allEmployees;

  EmployeeBloc({
    required EmployeeRepository employeeRepository,
  })  : _employeeRepository = employeeRepository,
        super(EmployeeInitial()) {
    on<LoadAllEmployees>(_loadAllEmployees);
    on<AddEmployee>(_addEmployee);
    on<UpdateEmployee>(_updateEmployee);
    on<DeleteEmployee>(_deleteEmployee);
    on<UndoDeleteEmployee>(_undoDeleteEmployee);
  }

  FutureOr<void> _loadAllEmployees(
    LoadAllEmployees event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(EmployeeLoading());
      final result = await _employeeRepository.getAllEmployee();
      _allEmployees
        ..clear()
        ..addAll(result);
      emit(EmployeeLoaded(employees: _allEmployees));
    } catch (e) {
      log(e.toString());
      emit(const EmployeeError());
    }
  }

  FutureOr<void> _addEmployee(
    AddEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(EmployeeLoading());
      await _employeeRepository.addEmployee(employee: event.employee);
      _allEmployees.insert(0, event.employee);
      emit(
        EmployeeLoaded(
          employees: _allEmployees,
          type: EmployeeLoadedType.add,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(const EmployeeError());
    }
  }

  FutureOr<void> _updateEmployee(
    UpdateEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(EmployeeLoading());
      await _employeeRepository.updateEmployee(employee: event.employee);
      final index = _allEmployees
          .indexWhere((emp) => emp.employeeId == event.employee.employeeId);
      if (index != -1) {
        _allEmployees.removeAt(index);
        _allEmployees.insert(index, event.employee);
        emit(
          EmployeeLoaded(
            employees: _allEmployees,
            type: EmployeeLoadedType.update,
          ),
        );
      } else {
        emit(const EmployeeError());
      }
    } catch (e) {
      log(e.toString());
      emit(const EmployeeError());
    }
  }

  FutureOr<void> _deleteEmployee(
    DeleteEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(EmployeeLoading());
      await _employeeRepository.deleteEmployee(employee: event.employee);
      lastDeletedEmployee = event.employee;
      lastDeletedIndex = _allEmployees.indexOf(event.employee);
      _allEmployees.remove(event.employee);
      emit(
        EmployeeLoaded(
          employees: _allEmployees,
          type: EmployeeLoadedType.delete,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(const EmployeeError());
    }
  }

  FutureOr<void> _undoDeleteEmployee(
    UndoDeleteEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      if (lastDeletedEmployee == null) {
        emit(const EmployeeError());
        return;
      }
      emit(EmployeeLoading());
      await _employeeRepository.addEmployee(employee: lastDeletedEmployee!);
      _allEmployees.insert(lastDeletedIndex ?? 0, lastDeletedEmployee!);
      lastDeletedEmployee = null;
      emit(EmployeeLoaded(employees: _allEmployees));
    } catch (e) {
      log(e.toString());
      emit(const EmployeeError());
    }
  }
}
