part of 'projects_bloc.dart';

@immutable
abstract class ProjectsState {
  final List<Project> projects;

  ProjectsState({this.projects});
}

class ProjectsInitial extends ProjectsState {

  ProjectsInitial(projects): super(projects: projects);

}
