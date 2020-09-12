import 'Tag.dart';

class Project {
  final String title;
  final List<Tag> tags;
  final DateTime startTime;
  final DateTime endTime;
  final String projectLink;

  Project({this.title, this.tags, this.startTime, this.endTime, this.projectLink});

}