import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubee_mini/features/signin/data/model/create_user_response.dart';
import 'package:ubee_mini/features/signin/data/model/update_names_and_birthdate_response.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/age_validation.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/create_user.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/email_validation.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/password_match_check.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/password_validation.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/update_names_and_birthdate.dart';
import 'package:ubee_mini/injection_container.dart' as injection;

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SignInState> {
  final imagePicker = ImagePicker();
  SigninBloc() : super(SignInState.initial()) {
    on<SigninEvent>((event, emit) {});

    on<TypingStarted>(_typingStarted);
    on<TypingEnded>(_typingEnded);

    on<EmailTypingStopped>(_validEmailCheck);
    on<PasswordTypingStopped>(_validPasswordCheck);
    on<PasswordConfirmationTypingStopped>(_matchPasswordCheck);
    on<CreateAccountClicked>(_createAccount);

    on<BirthdateChanged>(_validAge);
    on<ContinueSetupProfileClicked>(_continueSetupProfile);

    on<SelectImageFromLibraryClicked>(_selectFromLibrary);
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

    if (!isValidPassword) {
      state.addError(SignInStateError.invalidPassword);
      emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
    } else {
      state.removeError(SignInStateError.invalidPassword);
      if (!state.hasErrors()) {
        emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
      }
    }
  }

  void _matchPasswordCheck(PasswordConfirmationTypingStopped event,
      Emitter<SignInState> emit) async {
    bool isPasswordMatch = await injection.sl<PasswordMatchCheck>().call(
        PasswordMathcCheckParams(event.password, event.confirmationPassword));

    if (!isPasswordMatch) {
      state.addError(SignInStateError.notMatichingPassword);
      emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
    } else {
      state.removeError(SignInStateError.notMatichingPassword);
      if (!state.hasErrors()) {
        emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
      }
    }
  }

  void _createAccount(
      CreateAccountClicked event, Emitter<SignInState> emit) async {
    CreateUserResponse createUserResponse = await injection
        .sl<CreateUser>()
        .call(CreateUserParams(event.email, event.password));

    if (createUserResponse.isSuccess) {
      state.removeError(SignInStateError.unattendedError);
      state.removeError(SignInStateError.emailAlreadyInUse);
      state.removeError(SignInStateError.invalidEmail);
      state.removeError(SignInStateError.weakPassword);
      state.removeError(SignInStateError.operationNotAllowed);
      emit(state.copyWith(signInStateStatus: SignInStateStatus.userSuccessfullyCreated));
    } else {
      switch (createUserResponse.responseError) {
        case CreateUserResponseError.none:
          state.hasError(SignInStateError.unattendedError);
          state.removeError(SignInStateError.emailAlreadyInUse);
          state.removeError(SignInStateError.invalidEmail);
          state.removeError(SignInStateError.weakPassword);
          state.removeError(SignInStateError.operationNotAllowed);
          emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
          break;
        case CreateUserResponseError.emailAlreadyInUse:
          state.hasError(SignInStateError.emailAlreadyInUse);
          state.removeError(SignInStateError.unattendedError);
          state.removeError(SignInStateError.invalidEmail);
          state.removeError(SignInStateError.weakPassword);
          state.removeError(SignInStateError.operationNotAllowed);
          emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
        case CreateUserResponseError.invalidEmail:
          state.hasError(SignInStateError.invalidEmail);
          state.removeError(SignInStateError.unattendedError);
          state.removeError(SignInStateError.emailAlreadyInUse);
          state.removeError(SignInStateError.weakPassword);
          state.removeError(SignInStateError.operationNotAllowed);
          emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
        case CreateUserResponseError.weakPassword:
          state.hasError(SignInStateError.weakPassword);
          state.removeError(SignInStateError.unattendedError);
          state.removeError(SignInStateError.emailAlreadyInUse);
          state.removeError(SignInStateError.invalidEmail);
          state.removeError(SignInStateError.operationNotAllowed);
          emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
        case CreateUserResponseError.operationNotAllowed:
          state.hasError(SignInStateError.operationNotAllowed);
          state.removeError(SignInStateError.unattendedError);
          state.removeError(SignInStateError.emailAlreadyInUse);
          state.removeError(SignInStateError.invalidEmail);
          state.removeError(SignInStateError.weakPassword);
          emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
        default:
          state.removeError(SignInStateError.unattendedError);
          state.removeError(SignInStateError.emailAlreadyInUse);
          state.removeError(SignInStateError.invalidEmail);
          state.removeError(SignInStateError.weakPassword);
          state.removeError(SignInStateError.operationNotAllowed);
          emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
      }
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
    UpdateNamesAndBirthdateResponse updateResponse = await injection
        .sl<UpdateNamesAndBirthdate>()
        .call(UpdateNamesAndBirthdateParams(
            event.firstName, event.lastName, event.birthDate));

    if (updateResponse.isSuccess) {
      state.removeError(SignInStateError.notLogedIn);
      emit(state.copyWith(signInStateStatus: SignInStateStatus.namesBirthdateSucessfullyUpdated));
    } else {
      switch (updateResponse.responseError) {
        case UpdateNamesAndBirthdateRepsonseError.notLogedIn:
          state.addError(SignInStateError.notLogedIn);
          emit(state.copyWith(signInStateStatus: SignInStateStatus.error));
          break;
        default:
          state.removeError(SignInStateError.notLogedIn);
          emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
      }
    }
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
}
