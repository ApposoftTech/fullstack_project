import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_state.dart';
import 'blocs/task/task_bloc.dart';
import 'core/api_service.dart';
import 'screens/login_screen.dart';
import 'screens/task_list_screen.dart';

void main() {
  final apiService = ApiService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(apiService: apiService)),
        BlocProvider<TaskBloc>(
            create: (context) => TaskBloc(apiService: apiService)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return TaskListScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
