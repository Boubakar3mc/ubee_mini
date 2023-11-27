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
