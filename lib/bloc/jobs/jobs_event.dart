part of 'jobs_bloc.dart';

@immutable
abstract class JobsEvent {
  final String jobTitle;
  JobsEvent({this.jobTitle});
}

class JobToggleSaved extends JobsEvent {
  JobToggleSaved(jobTitle): super(jobTitle: jobTitle);
}

class JobToggleApplied extends JobsEvent {
  JobToggleApplied(jobTitle): super(jobTitle: jobTitle);
}