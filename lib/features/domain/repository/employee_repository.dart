import '../entity/employee.dart';

abstract class EmployeeRepository {
  Stream<List<Employee>> getEmployees();
  Future<void> addEmployee(Employee employee);
}