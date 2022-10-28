import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_planner/app/first_page/first_page.dart';

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
        child: Column(
          children: [
            Text('You are logged as ${user.email}'),
            ElevatedButton(
              child: const Text("Start"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FirstPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
