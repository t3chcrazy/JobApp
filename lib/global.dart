import 'package:flutter/material.dart';
import 'models/Job.dart';

class GlobalState extends InheritedWidget {

  final List<Job> jobList;

  GlobalState({this.jobList, Widget child}): super(child: child);

  @override
  bool updateShouldNotify(GlobalState oldWidget) => true;

}