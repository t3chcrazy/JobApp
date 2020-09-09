import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../bloc/skills/skills_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/Tag.dart';

class SkillModal extends StatefulWidget {

  @override
  _SkillModalState createState() => _SkillModalState();
}

class _SkillModalState extends State<SkillModal> {
  final TextEditingController _tagController = TextEditingController();

  void _handleSkillAdd(BuildContext ctx) {
    final newTag = Tag(tagName: _tagController.text, tagColor: _generateRandomColor());
    BlocProvider.of<SkillsBloc>(ctx).add(SkillsAdded(skillToAdd: newTag));
  }

  Color _generateRandomColor() => Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+30),
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
            onPressed: () => _handleSkillAdd(context),
          )
        ],
      ),
    );
  }
}