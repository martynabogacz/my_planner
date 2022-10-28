import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_planner/app/home/add_activity/add_activity_page_content.dart';
import 'package:my_planner/app/home/calendar/calendar_page_content.dart';
import 'package:my_planner/app/home/my_account/my_account_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My planner"),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const CalendarPageContent();
        }
        if (currentIndex == 1) {
          return const AddActivityPageContent();
        }
        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_sharp), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'My account'),
        ],
      ),
    );
  }
}






