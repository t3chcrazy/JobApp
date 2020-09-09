import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:itjobs/models/PreviousJob.dart';
import 'package:meta/meta.dart';
import '../../utils/JobList.dart';

part 'previous_event.dart';
part 'previous_state.dart';

class PreviousBloc extends Bloc<PreviousEvent, PreviousState> {
  PreviousBloc() : super(PreviousInitial(userPreviousJobs));

  @override
  Stream<PreviousState> mapEventToState(
    PreviousEvent event,
  ) async* {
    if (event is PreviousAdded) {
      final newPrevJob = event.prevJobAdded;
      final List<PreviousJob> newList = state.prevJobs.sublist(0);
      newList.add(newPrevJob);
      yield PreviousInitial(newList);
    }
    else if (event is PreviousDeleted) {
      final List<PreviousJob> newList = state.prevJobs.where((element) => element.job.jobTitle != event.prevJobDeleted.job.jobTitle).toList();
      yield PreviousInitial(newList);
    }
  }
}
