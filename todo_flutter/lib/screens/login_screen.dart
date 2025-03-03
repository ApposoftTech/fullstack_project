import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import 'task_list_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TaskListScreen()),
                  );
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return CircularProgressIndicator();
                }
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        if (email.isNotEmpty && password.isNotEmpty) {
                          context.read<AuthBloc>().add(LoginEvent(email:email, password:password));
                        }
                      },
                      child: Text('Login'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text('Don’t have an account? Register here'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
