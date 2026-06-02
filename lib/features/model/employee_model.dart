import '../domain/entity/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.name,
    required super.role,
    required super.attendance,
    required super.tasks,
    required super.late,
    required super.score,
  });

  factory EmployeeModel.fromMap(String id, Map<String, dynamic> map) {
    return EmployeeModel(
      id: id,
      name: map['name'] ?? '',
      role: map['role'] ?? '',
      attendance: map['attendance'] ?? 0,
      tasks: map['tasks'] ?? 0,
      late: map['late'] ?? 0,
      score: map['score'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "role": role,
      "attendance": attendance,
      "tasks": tasks,
      "late": late,
      "score": score,
    };
  }
}