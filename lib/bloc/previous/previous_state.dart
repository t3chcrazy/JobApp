part of 'previous_bloc.dart';

@immutable
abstract class PreviousState {

  final List<PreviousJob> prevJobs;

  PreviousState(this.prevJobs);

}

class PreviousInitial extends PreviousState {
  
  
  PreviousInitial(prevJobs): super(prevJobs);
}
