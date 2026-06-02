import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String name;
  final String role;
  final int attendance;
  final int tasks;
  final int late;
  final int score;

  const Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.attendance,
    required this.tasks,
    required this.late,
    required this.score,
  });

  @override
  List<Object?> get props => [id, name, role, score];
}