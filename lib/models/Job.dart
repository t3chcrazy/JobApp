import 'Company.dart';
import 'Tag.dart';

enum JobType {Contract, Fulltime, PartTime, Internship}

class Job {
  final String jobTitle;
  final Company jobCompany;
  final int jobSalary;
  final List<Tag> jobTags;
  final bool jobIsSaved;
  final JobType jobType;
  final DateTime jobDatePosted;

  const Job({this.jobTitle, this.jobCompany, this.jobSalary, this.jobTags, this.jobIsSaved, this.jobType, this.jobDatePosted});

}