// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:my_planner/app/features/second_page/second_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  //final controller = TextEditingController();

  var activityName = '';
  var activityTime = '';
  var activityPriority = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My planner"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ElevatedButton(
              child: const Text("Back"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SecondPage(),
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
