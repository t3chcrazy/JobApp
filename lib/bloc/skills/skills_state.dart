part of 'skills_bloc.dart';

@immutable
abstract class SkillsState {
  final List<Tag> skillTags;

  SkillsState(this.skillTags);

}

class SkillsInitial extends SkillsState {
  

  SkillsInitial(skillTags): super(skillTags);

}