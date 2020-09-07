import 'package:flutter/material.dart';
import '../bloc/skills/skills_bloc.dart';

class ProfileSection extends StatefulWidget {

  final String title;
  final List sectionItems;

  ProfileSection({this.title, this.sectionItems});

  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {

  bool isEditing;

  @override
  void initState() {
    super.initState();
    isEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.title),
              SizedBox(width: 10),
              AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: isEditing? 1: 0,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {}
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}