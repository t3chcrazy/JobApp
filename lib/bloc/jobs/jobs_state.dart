part of 'jobs_bloc.dart';

@immutable
abstract class JobsState {
  final List<Job> jobs;
  JobsState({this.jobs});
}

class JobsInitial extends JobsState {
  JobsInitial(initialJobs): super(jobs: initialJobs);
}
