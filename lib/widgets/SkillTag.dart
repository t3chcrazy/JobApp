import 'package:flutter/material.dart';
import '../models/Tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/skills/skills_bloc.dart';

class SkillTag extends StatelessWidget {

  final Tag skillTag;
  final bool isEditing;

  SkillTag({this.skillTag, this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isEditing? BlocProvider.of<SkillsBloc>(context).add(SkillDeleted(skillToDelete: skillTag)): {}, 
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(right: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: skillTag.tagColor.withAlpha(100),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(skillTag.tagName, style: TextStyle(fontSize: 10, color: skillTag.tagColor)),
            if (isEditing)
              Icon(Icons.delete, size: 8)
          ],
        )
      ),
    );
  }
}