part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

final class TypingStarted extends SigninEvent{
  
}

final class TypingEnded extends SigninEvent{
  
}

final class EmailTypingStopped extends SigninEvent{
  final String email;

  const EmailTypingStopped(this.email);
}

final class PasswordTypingStopped extends SigninEvent {
  final String password;
  final String confirmationPassword;

  const PasswordTypingStopped(this.password,this.confirmationPassword);
}


final class CreateAccountClicked extends SigninEvent{
  final String email;
  final String password;

  const CreateAccountClicked(this.email,this.password);
}

final class BirthdateChanged extends SigninEvent{
  final DateTime birthDate;

  const BirthdateChanged(this.birthDate);
}

final class ContinueSetupProfileClicked extends SigninEvent{
  final String firstName;
  final String lastName;
  final DateTime birthDate;

  const ContinueSetupProfileClicked(this.firstName,this.lastName,this.birthDate);
}

final class SelectImageFromLibraryClicked extends SigninEvent{
  
}

final class TakeImageWithCameraClicked extends SigninEvent{}

final class PictureSelected extends SigninEvent{
  const PictureSelected();
}

final class ChangePictureClicked extends SigninEvent{}

