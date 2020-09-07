import 'package:flutter/material.dart';

class SkillModal extends StatelessWidget {

  final Function handleSkillAdd;

  SkillModal({this.handleSkillAdd});

  final TextEditingController _tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _tagController,
            decoration: InputDecoration(
              labelText: "Skill Name"
            ),
          ),
          RaisedButton(
            child: Text("Add"),
            onPressed: handleSkillAdd,
          )
        ],
      ),
    );
  }
}