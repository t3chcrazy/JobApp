import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/projects/projects_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/Project.dart';
import 'SkillTag.dart';

class ProjectCard extends StatelessWidget {

  final Project project;
  final bool isEditing;

  ProjectCard({this.project, this.isEditing});

  void _openProject() async {
    final link = project.projectLink;
    if (await canLaunch(link)) {
      await launch(link);
    }
  }

  String formatDate(DateTime date) => date.toIso8601String().substring(0, 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFf5f6fa),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(
          color: const Color(0x29000000),
          offset: Offset(0,0),
          blurRadius: 6,
          spreadRadius: 0
        )]
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title),
                Row(
                  children: project.tags.map((t) => SkillTag(skillTag: t,)).toList(),
                ),
                GestureDetector(
                  onTap: _openProject,
                  child: Row(
                    children: [
                      Icon(Icons.star),
                      Text("Project link")
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                if (isEditing)
                  GestureDetector(
                    onTap: () => BlocProvider.of<ProjectsBloc>(context).add(ProjectRemoved(projectToRemove: project)),
                    child: Icon(Icons.delete_forever),
                  )
                ,
                Spacer(),
                Text("${formatDate(project.startTime)} - ${formatDate(project.endTime)}", style: TextStyle(fontSize: 10))
              ],
            ),
          )
        ],
      ),
    );
  }
}