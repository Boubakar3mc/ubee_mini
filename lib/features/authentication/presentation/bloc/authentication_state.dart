part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();  

  @override
  List<Object> get props => [];
}
class AuthenticationInitial extends AuthenticationState {}

class AuthenticationInvalidEmail extends AuthenticationState{}

abstract class AuthenticationErrorState extends AuthenticationState{}
 
class AuthenticationInvalidPassword extends AuthenticationErrorState {}

class AuthenticationNotMatchingPassword extends AuthenticationErrorState{}

class AuthenticationUnattendedError extends AuthenticationErrorState{
  
}

class AuthenticationEmailAlreadyInUse extends AuthenticationErrorState{}

class AuthenticationWeakPassword extends AuthenticationErrorState{}

class AuthenticationOperationNotAllowed extends AuthenticationErrorState{}

class AuthenticationUserSuccessfullyCreated extends AuthenticationState{}

class AuthenticationInvalidAge extends AuthenticationErrorState{}

