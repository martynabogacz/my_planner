import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddActivityPageContent extends StatelessWidget {
  const AddActivityPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Please wait"));
          }
          return const Center(
            child: Text("dwa"),
          );
        });
  }
}
