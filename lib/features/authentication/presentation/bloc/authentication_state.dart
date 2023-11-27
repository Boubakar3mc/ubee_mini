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
