part of 'skills_bloc.dart';

@immutable
abstract class SkillsEvent {}

class SkillsAdded extends SkillsEvent {

  final Tag skillToAdd;
  
  SkillsAdded({this.skillToAdd});

}

class SkillDeleted extends SkillsEvent {

  final Tag skillToDelete;

  SkillDeleted({this.skillToDelete});

}