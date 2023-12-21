import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubee_mini/features/signin/data/model/create_user_response.dart';
import 'package:ubee_mini/features/signin/data/model/update_user_response.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/age_validation.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/create_user.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/email_validation.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/password_match_check.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/password_validation.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/update_user.dart';
import 'package:ubee_mini/injection_container.dart' as injection;

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SignInState> {
  final imagePicker = ImagePicker();
  SigninBloc() : super(SignInState.initial()) {
    on<SigninEvent>((event, emit) {});
    on<ChangingPage>(_changePage);

    on<TypingStarted>(_typingStarted);
    on<TypingEnded>(_typingEnded);

    on<EmailTypingStopped>(_validEmailCheck);
    on<PasswordTypingStopped>(_validPasswordCheck);
    on<CreateAccountClicked>(_createAccount);

    on<BirthdateChanged>(_validAge);
    on<ContinueSetupProfileClicked>(_continueSetupProfile);

    on<SelectImageFromLibraryClicked>(_selectFromLibrary);
    on<TakeImageWithCameraClicked>(_takeFromCamera);
    on<ChangePictureClicked>(_changePicture);
    on<ConfirmButtonClicked>(_confirmReviewProfile);
  }

  void _changePage(ChangingPage event, Emitter<SignInState> emit){
    emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
  }

  void _typingStarted(TypingStarted event, Emitter<SignInState> emit) {
    emit(state.copyWith(signInStateStatus: SignInStateStatus.typing));
  }

  void _typingEnded(TypingEnded event, Emitter<SignInState> emit) {
    emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
  }

  void _validEmailCheck(
      EmailTypingStopped event, Emitter<SignInState> emit) async {
    bool isValidEmail = await injection
        .sl<EmailValidation>()
        .call(EmailValidationParams(event.email));
    if (!isValidEmail) {
      state.addError(SignInStateError.invalidEmail);
      emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
    } else {
      state.removeError(SignInStateError.invalidEmail);
      state.removeError(SignInStateError.emailAlreadyInUse);
      if (!state.hasErrors()) {
        emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
      }
    }
  }

  void _validPasswordCheck(
      PasswordTypingStopped event, Emitter<SignInState> emit) async {
    bool isValidPassword = await injection
        .sl<PasswordValidation>()
        .call(PasswordValidationParams(event.password));

    bool isPasswordMatch = await injection.sl<PasswordMatchCheck>().call(
        PasswordMathcCheckParams(event.password, event.confirmationPassword));

    isValidPassword
        ? state.removeError(SignInStateError.invalidPassword)
        : state.addError(SignInStateError.invalidPassword);

    isPasswordMatch
        ? state.removeError(SignInStateError.notMatichingPassword)
        : state.addError(SignInStateError.notMatichingPassword);

    state.hasErrors()
        ? emit(state.copyWith(signInStateStatus: SignInStateStatus.error))
        : emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
  }

  void _createAccount(
      CreateAccountClicked event, Emitter<SignInState> emit) async {
    CreateUserResponse createUserResponse = await injection
        .sl<CreateUser>()
        .call(CreateUserParams(event.email, event.password));

    if (createUserResponse.isSuccess) {
      state.removeAllErrors();
      emit(state.copyWith(
          signInStateStatus: SignInStateStatus.userSuccessfullyCreated));
    } else {
      switch (createUserResponse.responseError) {
        case CreateUserResponseError.none:
          state.onlyError(SignInStateError.unattendedError);
          break;
        case CreateUserResponseError.emailAlreadyInUse:
          state.onlyError(SignInStateError.emailAlreadyInUse);
          break;
        case CreateUserResponseError.invalidEmail:
          state.onlyError(SignInStateError.invalidEmail);
          break;
        case CreateUserResponseError.weakPassword:
          state.onlyError(SignInStateError.weakPassword);
          break;
        case CreateUserResponseError.operationNotAllowed:
          state.onlyError(SignInStateError.operationNotAllowed);
          break;
        default:
          state.onlyError(SignInStateError.unknown);
          break;
      }
      emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
    }
  }

  void _validAge(BirthdateChanged event, Emitter<SignInState> emit) async {
    bool isValidBirthdate = await injection
        .sl<AgeValidation>()
        .call(AgeValidationParams(event.birthDate));

    if (!isValidBirthdate) {
      state.addError(SignInStateError.invalidAge);
      emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
    } else {
      state.removeError(SignInStateError.invalidAge);
      if (!state.hasErrors()) {
        emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
      }
    }
  }

  void _continueSetupProfile(
      ContinueSetupProfileClicked event, Emitter<SignInState> emit) async {
    emit(state.copyWith(
        firstName: event.firstName,
        lastName: event.lastName,
        birthDate: event.birthDate,
        signInStateStatus: SignInStateStatus.namesBirthdateSetted));
  }

  void _selectFromLibrary(
      SelectImageFromLibraryClicked event, Emitter<SignInState> emit) async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      File selectedFile = File(selectedImage.path);
      emit(state.copyWith(
          signInStateStatus: SignInStateStatus.pictureSelected,
          selectedImage: selectedFile));
    }
  }

  void _takeFromCamera(
      TakeImageWithCameraClicked event, Emitter<SignInState> emit) async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      File selectedFile = File(selectedImage.path);
      emit(state.copyWith(
          signInStateStatus: SignInStateStatus.pictureSelected,
          selectedImage: selectedFile));
    }
  }

  void _changePicture(ChangePictureClicked event, Emitter<SignInState> emit){
    emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
  }

  void _confirmReviewProfile(ConfirmButtonClicked event, Emitter<SignInState> emit) async{
    UpdateUserResponse response = await injection.sl<UpdateUser>().call(UpdateUserParams(event.firstName, event.lastName, event.birthDate, event.pictureFile));

   if(response.isSuccess){
      state.removeAllErrors();
      emit(state.copyWith(signInStateStatus: SignInStateStatus.userSuccessfullyUpdated));
   }
   else{
    switch (response.responseError){
      case UpdateUserResponseError.none:
        state.onlyError(SignInStateError.unattendedError);
        break;
      case UpdateUserResponseError.notLogedIn:
        state.onlyError(SignInStateError.notLogedIn);
        break;
      case UpdateUserResponseError.retryLimitExceeded:
        state.onlyError(SignInStateError.retryLimitExceeded);
        break;
      case UpdateUserResponseError.unauthorized:
        state.onlyError(SignInStateError.unauthorized);
        break;
      case UpdateUserResponseError.unknown:
      default:
        state.onlyError(SignInStateError.unknown);
        break;
    }
    emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
   } 
  }
}
