import 'package:flutter/material.dart';

class Responsibilities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = TextStyle(color: Colors.grey, fontSize: 18);
    final desc = TextStyle(fontSize: 13);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Principal Software Engineer Responsibilities:", style: title),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Designing, coding, and debugging software.", style: desc),
              Text("Improving the performance of existing software.", style: desc),
              Text("Providing training to other engineers.", style: desc),
              Text("Maintaining and upgrading existing software.", style: desc),
              Text("Recommending new technologies that can help increase productivity.", style: desc),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text("Principal Software Engineer Requirements:", style: title),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bachelor’s degree in Computer Engineering/Computer Science or related field.", style: desc),
              Text("Strong analytical skills.", style: desc),
              Text("Good communication skills.", style: desc),
              Text("Excellent organizational and leadership skills.", style: desc),
              Text("Proven experience in high-level programming languages.", style: desc),
            ],
          ),
        )
      ],
    );
  }
}