import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/password_validation.dart';
import 'package:ubee_mini/injection_container.dart' as injection;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});

    on<PasswordTypingStopped>(_validPasswordCheck);
  }

  void _validPasswordCheck(PasswordTypingStopped event, Emitter<AuthenticationState> emit) async{
    bool isValidPassword= await injection.sl<PasswordValidation>().call(PasswordValidationParams(event.password));

    isValidPassword?emit(AuthenticationValidPassword()):emit(AuthenticationInvalidPassword());

  }
}
