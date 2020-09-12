part of 'projects_bloc.dart';

@immutable
abstract class ProjectsEvent {

  final Project selectedProject;

  ProjectsEvent({this.selectedProject});

}


class ProjectAdded extends ProjectsEvent {

  ProjectAdded({projectToAdd}): super(selectedProject: projectToAdd);

}

class ProjectRemoved extends ProjectsEvent {

  ProjectRemoved({projectToRemove}): super(selectedProject: projectToRemove);

}