// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_bloc.dart';

enum SignInStateError {
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
  namesBirthdateSetted,
  error,
}

class SignInState{
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final File selectedImage;
  final String email;
  final SignInStateStatus signInStateStatus;
  List<SignInStateError> errors = []; 

  SignInState({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.selectedImage,
    required this.email,
    required this.signInStateStatus,
  });

  factory SignInState.initial() => SignInState(firstName: "", lastName: "", birthDate: DateTime.now(), selectedImage: File('NoFile'), email: "", signInStateStatus: SignInStateStatus.initial); 
  

  void addError(SignInStateError error){
    if(errors.contains(error)) return;

    errors.add(error);
  }

  bool hasError(SignInStateError error){
    if(errors.contains(error)) return true;
    return false;
  }

  bool hasErrors(){
    if(errors.isNotEmpty) return true;
    return false;
  }

  void removeError(SignInStateError error){
    errors.remove(error);
  }

  SignInState copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    File? selectedImage,
    String? email,
    SignInStateStatus? signInStateStatus,
  }) {
    var newSignInState = SignInState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      selectedImage: selectedImage ?? this.selectedImage,
      email: email ?? this.email,
      signInStateStatus: signInStateStatus ?? this.signInStateStatus,
    );

    newSignInState.errors = errors;
    return newSignInState;
  }
}
