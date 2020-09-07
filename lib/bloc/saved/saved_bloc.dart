import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(SavedInitial());

  @override
  Stream<SavedState> mapEventToState(
    SavedEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
