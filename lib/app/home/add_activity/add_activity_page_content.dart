import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddActivityPageContent extends StatefulWidget {
  const AddActivityPageContent({
    required this.onSave,
    Key? key,
  }) : super(key: key);

  final Function onSave;

  @override
  State<AddActivityPageContent> createState() => _AddActivityPageContentState();
}

class _AddActivityPageContentState extends State<AddActivityPageContent> {
  var activityName = '';
  var activityTime = '';
  var activityPriority = 1.0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          // if (snapshot.hasError) {
          //   return const Center(child: Text("Error"));
          // }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: Text("Please wait"));
          // }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextField(
                    decoration:
                        const InputDecoration(hintText: 'Activity name'),
                    onChanged: (newValue) {
                      setState(() {
                        activityName = newValue;
                      });
                    },
                  ),
                  TextField(
                    decoration:
                        const InputDecoration(hintText: 'Activity time'),
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
                  const Center(
                      child: Text("Choose activity priority from 1-10")),
                  ElevatedButton(
                    onPressed: activityName.isEmpty || activityTime.isEmpty
                        ? null
                        : () {
                            FirebaseFirestore.instance
                                .collection('categories')
                                .add(
                              {
                                'priority': activityPriority,
                                'time': activityTime,
                                'title': activityName
                              },
                            );
                            widget.onSave();
                          },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
