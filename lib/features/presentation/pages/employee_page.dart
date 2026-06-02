import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../bloc/employee_state.dart';

import '../../domain/entity/employee.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smart Workforce System")),

      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {

          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmployeeLoaded) {
            return ListView.builder(
              itemCount: state.employees.length,
              itemBuilder: (context, index) {
                final e = state.employees[index];

                return Card(
                  child: ListTile(
                    title: Text(e.name),
                    subtitle: Text(
                      "Role: ${e.role}\nScore: ${e.score}",
                    ),
                    trailing: CircleAvatar(
                      child: Text("${e.score}"),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("No Data"));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          context.read<EmployeeBloc>().add(
            AddEmployee(
              Employee(
                id: "",
                name: "Akhil",
                role: "Flutter Dev",
                attendance: 20,
                tasks: 15,
                late: 2,
                score: 0,
              ),
            ),
          );

          await FirebaseAnalytics.instance.logEvent(
            name: 'employee_added',
            parameters: {
              'employee_name': 'Akhil',
              'role': 'Flutter Dev',
            },
          );

          FirebaseCrashlytics.instance.crash();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}