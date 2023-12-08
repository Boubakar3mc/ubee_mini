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

class SigninBloc
    extends Bloc<SigninEvent, SignInState> {
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

    isValidEmail
        ? emit(state.copyWith(signInStateStatus: SignInStateStatus.initial, signInStateError: SignInStateError.none))
        : emit(state.copyWith(signInStateError: SignInStateError.invalidEmail));
  }

  void _validPasswordCheck(
      PasswordTypingStopped event, Emitter<SignInState> emit) async {
    bool isValidPassword = await injection
        .sl<PasswordValidation>()
        .call(PasswordValidationParams(event.password));

    isValidPassword
        ? emit(state.copyWith(signInStateStatus: SignInStateStatus.initial, signInStateError: SignInStateError.none))
        : emit(state.copyWith(signInStateError: SignInStateError.invalidPassword));
  }

  void _matchPasswordCheck(PasswordConfirmationTypingStopped event,
      Emitter<SignInState> emit) async {
    bool isPasswordMatch = await injection.sl<PasswordMatchCheck>().call(
        PasswordMathcCheckParams(event.password, event.confirmationPassword));

    isPasswordMatch
        ? emit(state.copyWith(signInStateStatus: SignInStateStatus.initial, signInStateError: SignInStateError.none))
        : emit(state.copyWith(signInStateError: SignInStateError.notMatichingPassword));
  }

  void _createAccount(
      CreateAccountClicked event, Emitter<SignInState> emit) async {
    CreateUserResponse createUserResponse = await injection
        .sl<CreateUser>()
        .call(CreateUserParams(event.email, event.password));

    if (createUserResponse.isSuccess) {
      emit(state.copyWith(signInStateStatus: SignInStateStatus.userSuccessfullyCreated, signInStateError: SignInStateError.none));
    } else {
      switch (createUserResponse.responseError) {
        case CreateUserResponseError.none:
          emit(state.copyWith(signInStateError: SignInStateError.unattendedError));
          break;
        case CreateUserResponseError.emailAlreadyInUse:
          emit(state.copyWith(signInStateError: SignInStateError.emailAlreadyInUse));
          break;
        case CreateUserResponseError.invalidEmail:
          emit(state.copyWith(signInStateError: SignInStateError.invalidEmail));
          break;
        case CreateUserResponseError.weakPassword:
          emit(state.copyWith(signInStateError: SignInStateError.weakPassword));
          break;
        case CreateUserResponseError.operationNotAllowed:
          emit(state.copyWith(signInStateError: SignInStateError.operationNotAllowed));
          break;
        default:
          emit(state.copyWith(signInStateStatus: SignInStateStatus.initial));
      }
    }
  }

  void _validAge(
      BirthdateChanged event, Emitter<SignInState> emit) async {
    bool isValidBirthdate = await injection
        .sl<AgeValidation>()
        .call(AgeValidationParams(event.birthDate));

    isValidBirthdate
        ? emit(state.copyWith(signInStateStatus: SignInStateStatus.initial, signInStateError: SignInStateError.none))
        : emit(state.copyWith(signInStateError: SignInStateError.invalidAge));
  }

  void _continueSetupProfile(ContinueSetupProfileClicked event,
      Emitter<SignInState> emit) async {

    UpdateNamesAndBirthdateResponse updateResponse = await injection
        .sl<UpdateNamesAndBirthdate>()
        .call(UpdateNamesAndBirthdateParams(
            event.firstName, event.lastName, event.birthDate));

    if (updateResponse.isSuccess) {
      emit(state.copyWith(signInStateStatus: SignInStateStatus.namesBirthdateSucessfullyUpdated, signInStateError: SignInStateError.none));
    } else {
      switch (updateResponse.responseError) {
        case UpdateNamesAndBirthdateRepsonseError.notLogedIn:
          emit(state.copyWith(signInStateError: SignInStateError.notLogedIn));
          break;
        default:
          emit(state.copyWith(signInStateStatus: SignInStateStatus.initial, signInStateError: SignInStateError.none));
      }
    }
  }

  void _selectFromLibrary(SelectImageFromLibraryClicked event,
      Emitter<SignInState> emit) async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      File selectedFile = File(selectedImage.path);
        emit(state.copyWith(signInStateStatus: SignInStateStatus.pictureSelected,selectedImage: selectedFile));
    }
  }
}
