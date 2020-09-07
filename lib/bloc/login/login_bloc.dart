import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoggedOut());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoginLoading();
    if (event is LoginInitiate) {
      await Future<void>.delayed(Duration(seconds: 3));
      yield LoggedIn();
    }
    else if (event is LogoutInitiate) {
      yield LoggedOut();
    }
  }

}
