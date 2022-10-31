import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        child: Text(title));
  }
}
