part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}


final class EmailTypingStopped extends AuthenticationEvent{
  final String email;

  const EmailTypingStopped(this.email);
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



final class CreateAccountClicked extends AuthenticationEvent{
  final String email;
  final String password;

  const CreateAccountClicked(this.email,this.password);
}

final class BirthdateChanged extends AuthenticationEvent{
  final DateTime birthDate;

  const BirthdateChanged(this.birthDate);
}

final class ContinueSetupProfileClicked extends AuthenticationEvent{
  final String firstName;
  final String lastName;
  final DateTime birthDate;

  const ContinueSetupProfileClicked(this.firstName,this.lastName,this.birthDate);
}
