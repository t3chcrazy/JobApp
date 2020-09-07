import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/Tag.dart';

part 'skills_event.dart';
part 'skills_state.dart';

class SkillsBloc extends Bloc<SkillsEvent, SkillsState> {
  SkillsBloc() : super(SkillsInitial(<Tag>[Tag(tagName: "React", tagColor: Colors.blue)]));

  @override
  Stream<SkillsState> mapEventToState(
    SkillsEvent event,
  ) async* {
    if (event is SkillDeleted) {
      final deletedSkill = event.skillToDelete;
      final newSkillList = state.skillTags.map((e) => e.tagName != deletedSkill.tagName);
      yield SkillsInitial(newSkillList);
    }
    else if (event is SkillsAdded) {
      final newSkill = event.skillToAdd;
      final newSkillList = state.skillTags.sublist(0);
      newSkillList.add(newSkill);
      yield SkillsInitial(newSkillList);
    }
  }
}
