import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itjobs/models/Tag.dart';
import '../bloc/projects/projects_bloc.dart';
import '../models/Project.dart';

class ProjectModal extends StatefulWidget {
  @override
  _ProjectModalState createState() => _ProjectModalState();
}

class _ProjectModalState extends State<ProjectModal> {

  final TextEditingController _title = TextEditingController();
  final TextEditingController _projectLink = TextEditingController();
  final TextEditingController _tags = TextEditingController();
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
    endDate = DateTime.now();
  }

  @override
  void dispose() {
    _title.dispose();
    _projectLink.dispose();
    super.dispose();
  }
  
  void _handleStartDate(BuildContext ctx) {
    showDatePicker(
      context: ctx, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()
    ).then((pickedStartDate) {
      if (pickedStartDate == null) {
        return;
      }
      setState(() {
        startDate = pickedStartDate;
      });
      showDatePicker(
        context: ctx, 
        initialDate: DateTime.now(),
        firstDate: DateTime(2019), 
        lastDate: DateTime.now()
      ).then((pickedEndDate) {
        setState(() {
          endDate = pickedEndDate;
        });
      });
    });
  }

  void _handleProjectAdd() {
    final newProject = Project(
      title: _title.text,
      startTime: startDate,
      endTime: endDate,
      projectLink: _projectLink.text,
      tags: _tags.text.split(",").map((e) => Tag(tagName: e, tagColor: Colors.yellow))
    );
    BlocProvider.of<ProjectsBloc>(context).add(ProjectAdded(projectToAdd: newProject));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+30),
      child: Column(
        children: [
          Text("Add Project"),
          TextField(
            controller: _title,
            decoration: InputDecoration(
              labelText: "Enter project title",
            ),
          ),
          TextField(
            controller: _projectLink,
            decoration: InputDecoration(
              labelText: "Enter project link",
            ),
          ),
          Row(
            children: [
              FlatButton(
                child: Text("Set start and end date"),
                onPressed: () => _handleStartDate(context),
              ),
              Text("${startDate.toIso8601String()} to ${endDate.toIso8601String()}")
            ],
          ),
          Container(
            height: 3*24.0,
            child: TextField(
              controller: _tags,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter tags separated by comma"
              ),
            ),
          ),
          RaisedButton(
            child: Text("Submit"),
            onPressed: _handleProjectAdd,
          )
        ],
      )
    );
  }
}