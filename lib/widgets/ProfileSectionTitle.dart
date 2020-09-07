import 'package:flutter/material.dart';

class ProfileSectionTitle extends StatelessWidget {

  final String title;

  ProfileSectionTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    final sectionTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: sectionTitle),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      )
    );
  }
}