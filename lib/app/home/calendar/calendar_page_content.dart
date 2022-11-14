import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_planner/app/widgets/category_widget.dart';

class CalendarPageContent extends StatelessWidget {
  const CalendarPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('categories')
              .orderBy('time', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            final documents = snapshot.data!.docs;

            // if (snapshot.hasError) {
            //   return Text("Error");
            // }
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Text("Please wait");
            // }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
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
                          CategoryWidget(
                            document['time'].toString(),
                          ),
                          //CategoryWidget(
                          //  document['priority'].toString(),
                          //),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
