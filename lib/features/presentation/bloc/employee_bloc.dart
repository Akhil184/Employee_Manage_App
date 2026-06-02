import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository/employee_repository.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository repository;

  EmployeeBloc(this.repository) : super(EmployeeLoading()) {

    on<LoadEmployees>((event, emit) async {
      await emit.forEach(
        repository.getEmployees(),
        onData: (data) => EmployeeLoaded(data),
        onError: (error, stackTrace) => EmployeeError(error.toString()),
      );
    });

    on<AddEmployee>((event, emit) async {
      await repository.addEmployee(event.employee);
    });
  }
}