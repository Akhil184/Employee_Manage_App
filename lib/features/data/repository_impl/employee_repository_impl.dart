import '../../domain/entity/employee.dart';
import '../../domain/repository/employee_repository.dart';
import '../../model/employee_model.dart';
import '../datasource/employee_datasource.dart';


class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeDataSource dataSource;

  EmployeeRepositoryImpl(this.dataSource);

  @override
  Stream<List<Employee>> getEmployees() {
    return dataSource.getEmployees();
  }

  @override
  Future<void> addEmployee(Employee employee) {
    final model = EmployeeModel(
      id: employee.id,
      name: employee.name,
      role: employee.role,
      attendance: employee.attendance,
      tasks: employee.tasks,
      late: employee.late,
      score: employee.score,
    );

    return dataSource.addEmployee(model);
  }

  @override
  Future<void> updateEmployee(Employee employee) {
    return dataSource.updateEmployee(employee.id, {
      "name": employee.name,
      "role": employee.role,
      "attendance": employee.attendance,
      "tasks": employee.tasks,
      "late": employee.late,
      "score": employee.score,
    });
  }

  @override
  Future<void> deleteEmployee(String id) {
    return dataSource.deleteEmployee(id);
  }
}