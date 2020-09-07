import 'package:flutter/material.dart';
import '../models/Tag.dart';

class SkillTag extends StatelessWidget {

  final Tag skillTag;

  SkillTag({this.skillTag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(right: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: skillTag.tagColor.withAlpha(100),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(skillTag.tagName, style: TextStyle(fontSize: 10, color: skillTag.tagColor))
    );
  }
}