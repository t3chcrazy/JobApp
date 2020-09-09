import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:itjobs/models/Job.dart';
import 'package:meta/meta.dart';
import '../../utils/JobList.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  JobsBloc() : super(JobsInitial(jobList));

  @override
  Stream<JobsState> mapEventToState(
    JobsEvent event,
  ) async* {
    final String jobTitle = event.jobTitle;
    final newList = state.jobs.sublist(0);
    final Job concernedJob = newList.firstWhere((element) => element.jobTitle == jobTitle);
    if (event is JobToggleSaved) {
      concernedJob.jobIsSaved = !concernedJob.jobIsApplied;
    }
    else if (event is JobToggleApplied) {
      concernedJob.jobIsApplied = !concernedJob.jobIsApplied;
    }
    yield JobsInitial(newList);
  }
}
