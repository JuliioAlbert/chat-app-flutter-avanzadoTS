part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Login extends AuthEvent {
  final String email, password;

  Login(this.email, this.password);
}

class Register extends AuthEvent {
  final String name, email, password;

  Register(this.name, this.email, this.password);
}

class IsLoggedIn extends AuthEvent {}

class Loggout extends AuthEvent {}
