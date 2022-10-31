// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_planner/app/second_page/second_page.dart';
import 'package:flutter/material.dart';
import 'package:my_planner/app/widgets/category_widget.dart';

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
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .orderBy('activityPriority', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                final documents = snapshot.data!.docs;

                // if (snapshot.hasError) {
                //   return Text("Error");
                // }
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Text("Please wait");
                // }
                return ListView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final document in documents) ...[
                      Dismissible(
                        key: ValueKey(document.id),
                        onDismissed: (_) {
                          FirebaseFirestore.instance
                              .collection('categories')
                              .doc(document.id)
                              .delete();
                        },
                        child: Row(
                          children: [
                            CategoryWidget(
                              document['title'],
                            ),
                            //CategoryWidget(
                            //  document['time'].toString(),
                            //),
                            CategoryWidget(
                              document['priority'].toString(),
                            ),
                          ],
                        ),
                      ),
                    ],
                    TextField(
                      decoration:
                          InputDecoration(hintText: 'Insert new activity'),
                      onChanged: (newValue) {
                        setState(() {
                          activityName = newValue;
                        });
                      },
                    ),
                    TextField(
                      decoration:
                          InputDecoration(hintText: 'Insert activity time'),
                      onChanged: (newValue) {
                        setState(() {
                          activityTime = newValue;
                        });
                      },
                    ),
                    Slider(
                      onChanged: (newValue) {
                        setState(() {
                          activityPriority = newValue;
                        });
                      },
                      value: activityPriority,
                      min: 1.0,
                      max: 10.0,
                      divisions: 10,
                      label: activityPriority.toString(),
                    ),
                    Center(
                        child:
                            const Text("Choose activity priority from 1-10")),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('categories').add(
                          {
                            'title': activityName,
                            'time': activityTime,
                            'priority': activityPriority
                          },
                        );
                      },
                      child: Text('Add'),
                    ),
                    SizedBox(height: 20),
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
                );
              }),
        ));
  }
}
