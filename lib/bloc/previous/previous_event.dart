part of 'previous_bloc.dart';

@immutable
abstract class PreviousEvent {}

class PreviousAdded extends PreviousEvent {
  final PreviousJob prevJobAdded;

  PreviousAdded({@required this.prevJobAdded});
}

class PreviousDeleted extends PreviousEvent {
  final PreviousJob prevJobDeleted;

  PreviousDeleted({@required this.prevJobDeleted});
}