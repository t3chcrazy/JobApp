import 'Tag.dart';
import 'Job.dart';
import 'PreviousJob.dart';

enum Status {Available, NoticePeriod, Unavailable}

class User {
  final String name;
  final Job currentJob;
  final Status status;
  final List<Tag> tags;
  final List<PreviousJob> jobHistory;
  final List<Map<String, String>> socialLinks;

  User({this.name, this.currentJob, this.status, this.tags, this.jobHistory, this.socialLinks});
}