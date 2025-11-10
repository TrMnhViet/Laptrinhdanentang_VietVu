// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectltdnt/bloc/auth_bloc.dart';
import 'package:projectltdnt/bloc/auth_event.dart';
import 'package:projectltdnt/screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(child: Text("Welcome, $username!")),
    );
  }
}
