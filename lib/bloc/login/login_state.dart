part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoggedIn extends LoginState {}

class LoginLoading extends LoginState {}

class LoggedOut extends LoginState {}