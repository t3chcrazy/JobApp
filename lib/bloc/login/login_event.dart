part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInitiate extends LoginEvent {

  final String email;
  final String password;

  LoginInitiate(this.email, this.password);

}

class LogoutInitiate extends LoginEvent {}