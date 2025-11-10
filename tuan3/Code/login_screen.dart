// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectltdnt/screen/home_screen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Demo")),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen(username: state.username)),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: "Username"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              SizedBox(height: 20),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthLoginRequested(
                              username: usernameController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                    child: Text("Login"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
