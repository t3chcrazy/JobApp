import 'package:flutter/material.dart';
import '../widgets/PreviousJob.dart';
import '../widgets/SkillTag.dart';
import 'SkillModal.dart';
import 'PreviousJobModal.dart';

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

  void _showSkillModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx, 
      builder: (context) => SkillModal()
    );
  }

  void _showPreviousJobModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) => PreviousJobModal(),
    );
  }

  void _showAptModal(BuildContext ctx) {
    if (widget.title == "Skills") {
      _showSkillModal(ctx);
    }
    else {
      _showPreviousJobModal(ctx);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSkills = widget.title == "Skills";
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              SizedBox(width: 10),
              AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: isEditing? 1: 0,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _showAptModal(context)
                ),
              ),
              Spacer(),
              IconButton(
                icon: isEditing? Icon(Icons.power_settings_new): Icon(Icons.edit),
                onPressed: () => setState(() {isEditing = !isEditing;}),
              )
            ],
          ),
          isSkills?
          Row(
            children: widget.sectionItems.map((e) => SkillTag(skillTag: e, isEditing: isEditing,)).toList(),
          ):
          Column(
            children: widget.sectionItems.map((e) => PreviousJobCard(isEditing: isEditing, pJob: e,)).toList(),
          )
        ],
      ),
    );
  }
}