import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_planner/app/cubit/root_cubit.dart';
import 'package:my_planner/app/features/first_page/first_page.dart';

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text('You are logged as $email'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<RootCubit>().signOut();
                },
                child: const Text("Log out"),
              ),
            ],
          ),
          ElevatedButton(
            child: const Text("Start"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FirstPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
