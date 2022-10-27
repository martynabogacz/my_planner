import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My planner"),
      ),
      body: Center(
        child: Text('You are logged as ${user.email}'),
      ),
    );
  }
}