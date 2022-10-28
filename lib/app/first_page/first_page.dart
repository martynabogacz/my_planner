// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_planner/app/second_page/second_page.dart';
import 'package:flutter/material.dart';
import 'package:my_planner/app/widgets/category_widget.dart';

class FirstPage extends StatelessWidget {
  FirstPage({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My planner"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FirebaseFirestore.instance.collection('categories').add(
              {'title': controller.text},
            );
            controller.clear();
          },
          child: Icon(Icons.add),
        ),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (context, snapshot) {
                final documents = snapshot.data!.docs;

                if (snapshot.hasError) {
                  return Text("Error");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Please wait");
                }
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
                        child: CategoryWidget(
                          document['title'],
                        ),
                      ),
                    ],
                    TextField(controller: controller),
                    Text("First page"),
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
