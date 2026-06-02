import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/data/datasource/employee_datasource.dart';
import 'features/data/repository_impl/employee_repository_impl.dart';
import 'features/domain/repository/employee_repository.dart';
import 'features/presentation/bloc/employee_bloc.dart';
import 'features/presentation/bloc/employee_event.dart';
import 'features/presentation/pages/employee_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(true);

  FlutterError.onError =
      FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    );
    return true;
  };

  final EmployeeRepository repository =
  EmployeeRepositoryImpl(
    EmployeeDataSource(),
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final EmployeeRepository repository;

  const MyApp({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) =>
        EmployeeBloc(repository)..add(LoadEmployees()),
        child: const EmployeePage(),
      ),
    );
  }
}