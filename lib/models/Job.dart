import 'Company.dart';
import 'Tag.dart';

enum JobType {Contract, Fulltime, PartTime, Internship}

class Job {
  final String jobTitle;
  final Company jobCompany;
  final int jobSalary;
  final List<Tag> jobTags;
  bool jobIsSaved;
  final JobType jobType;
  final DateTime jobDatePosted;
  bool jobIsApplied;

  Job({this.jobTitle, this.jobCompany, this.jobSalary, this.jobTags, this.jobIsSaved = false, this.jobType, this.jobDatePosted, this.jobIsApplied = false});

}