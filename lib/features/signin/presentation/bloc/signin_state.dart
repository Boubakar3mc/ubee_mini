// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_bloc.dart';

enum SignInStateError {
  none,
  invalidEmail,
  invalidPassword,
  notMatichingPassword,
  unattendedError,
  emailAlreadyInUse,
  weakPassword,
  operationNotAllowed,
  invalidAge,
  notLogedIn,
}

enum SignInStateStatus {
  initial,
  typing,
  userSuccessfullyCreated,
  pictureSelected,
  namesBirthdateSucessfullyUpdated,
}

class SignInState extends Equatable {
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final File selectedImage;
  final String email;
  final SignInStateError signInStateError;
  final SignInStateStatus signInStateStatus;

  const SignInState({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.selectedImage,
    required this.email,
    required this.signInStateError,
    required this.signInStateStatus,
  });

  factory SignInState.initial() => SignInState(firstName: "", lastName: "", birthDate: DateTime.now(), selectedImage: File('NoFile'), email: "", signInStateError: SignInStateError.none, signInStateStatus: SignInStateStatus.initial); 
  
  @override
  List<Object?> get props => [firstName,lastName,birthDate,selectedImage,email,signInStateError,signInStateStatus];



  SignInState copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    File? selectedImage,
    String? email,
    SignInStateError? signInStateError,
    SignInStateStatus? signInStateStatus,
  }) {
    return SignInState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      selectedImage: selectedImage ?? this.selectedImage,
      email: email ?? this.email,
      signInStateError: signInStateError ?? this.signInStateError,
      signInStateStatus: signInStateStatus ?? this.signInStateStatus,
    );
  }
}
