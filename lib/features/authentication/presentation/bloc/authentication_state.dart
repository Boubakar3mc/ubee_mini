part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();  

  @override
  List<Object> get props => [];
}
class AuthenticationInitial extends AuthenticationState {}

class AuthenticationInvalidEmail extends AuthenticationState{}

class AuthenticationInvalidPassword extends AuthenticationState {}

class AuthenticationNotMatchingPassword extends AuthenticationState{}

class AuthenticationUnattendedError extends AuthenticationState{
  
}

class AuthenticationEmailAlreadyInUse extends AuthenticationState{}

class AuthenticationWeakPassword extends AuthenticationState{}

class AuthenticationOperationNotAllowed extends AuthenticationState{}

class AuthenticationUserSuccessfullyCreated extends AuthenticationState{}

