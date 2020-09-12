import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:itjobs/models/Project.dart';
import 'package:itjobs/models/Tag.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(ProjectsInitial(<Project>[
    Project(
      title: "Corona Stats",
      projectLink: "https://github.com/t3chcrazy/CoronaStats",
      startTime: DateTime(2020, 8, 21),
      endTime: DateTime(2020, 8, 23),
      tags: <Tag>[
        Tag(tagName: "React-Native", tagColor: Colors.blue),
        Tag(tagName: "REST API", tagColor: Colors.red),
      ]
    ),
    Project(
      title: "Job App",
      projectLink: "https://github.com/t3chcrazy/JobApp",
      startTime: DateTime(2020, 8, 30),
      endTime: DateTime(2020, 9, 12),
      tags: <Tag>[
        Tag(tagName: 'Flutter', tagColor: Colors.lightBlueAccent),
        Tag(tagName: "Bloc", tagColor: Colors.yellow)
      ]
    )
  ]));

  @override
  Stream<ProjectsState> mapEventToState(
    ProjectsEvent event,
  ) async* {
    if (event is ProjectAdded) {
      final projectToAdd = event.selectedProject;
      final newList = state.projects.sublist(0);
      newList.add(projectToAdd);
      yield ProjectsInitial(newList);
    }
    else if (event is ProjectRemoved) {
      final newList = state.projects.where((element) => element.title != event.selectedProject.title);
      yield ProjectsInitial(newList);
    }
  }
}
