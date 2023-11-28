import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/features/authentication/data/model/create_user_response.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/create_user.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/email_validation.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/password_match_check.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/password_validation.dart';
import 'package:ubee_mini/injection_container.dart' as injection;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});

    on<EmailTypingStopped>(_validEmailCheck);
    on<PasswordTypingStopped>(_validPasswordCheck);
    on<PasswordConfirmationTypingStopped>(_matchPasswordCheck);
    on<CreateAccountClicked>(_createAccount);
  }

  void _validEmailCheck(EmailTypingStopped event, Emitter<AuthenticationState> emit) async{
    bool isValidEmail = await injection.sl<EmailValidation>().call(EmailValidationParams(event.email));

    isValidEmail?emit(AuthenticationInitial()):emit(AuthenticationInvalidEmail());
  }

  void _validPasswordCheck(PasswordTypingStopped event, Emitter<AuthenticationState> emit) async{
    bool isValidPassword= await injection.sl<PasswordValidation>().call(PasswordValidationParams(event.password));

    isValidPassword?emit(AuthenticationInitial()):emit(AuthenticationInvalidPassword());

  }

  void _matchPasswordCheck(PasswordConfirmationTypingStopped event, Emitter<AuthenticationState> emit) async{
    bool isPasswordMatch= await injection.sl<PasswordMatchCheck>().call(PasswordMathcCheckParams(event.password, event.confirmationPassword));

    isPasswordMatch?emit(AuthenticationInitial()):emit(AuthenticationNotMatchingPassword());
  }

  void _createAccount(CreateAccountClicked event, Emitter<AuthenticationState> emit) async{
    CreateUserResponse createUserResponse = await injection.sl<CreateUser>().call(CreateUserParams(event.email, event.password));

    if(createUserResponse.isSuccess){
      emit(AuthenticationUserSuccessfullyCreated());
    }
    else{
      switch (createUserResponse.responseError) {
        case CreateUserResponseError.none:
          emit(AuthenticationUnattendedError());
          break;
        case CreateUserResponseError.emailAlreadyInUse:
          emit(AuthenticationEmailAlreadyInUse());
          break;
        case CreateUserResponseError.invalidEmail:
          emit(AuthenticationInvalidEmail());
          break;
        case CreateUserResponseError.weakPassword:
          emit(AuthenticationWeakPassword());
          break;
        case CreateUserResponseError.operationNotAllowed:
          emit(AuthenticationOperationNotAllowed());
          break;
        default:
          emit(AuthenticationInitial());
      }
    }
  }

}
