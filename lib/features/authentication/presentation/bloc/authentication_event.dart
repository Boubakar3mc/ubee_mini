part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class PasswordTypingStopped extends AuthenticationEvent {
  final String password;

  const PasswordTypingStopped(this.password);
}

final class PasswordConfirmationTypingStopped extends AuthenticationEvent{
  final String password;
  final String confirmationPassword;

  const PasswordConfirmationTypingStopped(this.password,this.confirmationPassword);
}
