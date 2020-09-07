import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Lorem ipsum"),
        SizedBox(height: 20),
        Text("Lorem ipsum"),
        SizedBox(height: 20),
        Text("Lorem ipsum")
      ],
    );
  }
}