import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'applied_event.dart';
part 'applied_state.dart';

class AppliedBloc extends Bloc<AppliedEvent, AppliedState> {
  AppliedBloc() : super(AppliedInitial());

  @override
  Stream<AppliedState> mapEventToState(
    AppliedEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
