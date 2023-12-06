import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/components/simple_app_bar.dart';
import 'package:ubee_mini/core/utils/constants.dart';
import 'package:ubee_mini/core/utils/localized.dart';
import 'package:ubee_mini/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/dark_button.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/red_error_message.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/input_text_field.dart';
import 'package:ubee_mini/injection_container.dart' as injection;
import 'package:ubee_mini/core/route/route.dart' as route;
import 'dart:async';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  TextEditingController emailTextFieldController = TextEditingController();
  TextEditingController passwordTextFieldController = TextEditingController();
  TextEditingController passwordConfirmTextFieldController =
      TextEditingController();

  Timer? _emailValidationTypingTimer;
  Timer? _passwordValidationTypingTimer;
  Timer? _passwordMatchingTypingTimer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injection.sl<AuthenticationBloc>(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SimpleAppBar(localized(context).createAnAccount, onArrowPressed: () {}),
          body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationUserSuccessfullyCreated) {
                Navigator.pushNamed(context, route.welcomePage);
              }
            },
            builder: (context, state) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.055,
                    ),
                    Column(
                      children: [
                        InputTextField(
                          localized(context).enterEmailAdress,
                          controller: emailTextFieldController,
                          hintText: localized(context).emailHint,
                          onChanged: () {
                            emailValidationResetTimer(context);
                          },
                          errorMessage: _getEmailAdressErrorMessage(state,context),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InputTextField(
                          localized(context).createPassword,
                          controller: passwordTextFieldController,
                          onChanged: () {
                            passwordValidationResetTimer(context);
                          },
                          hintText: localized(context).passwordHint,
                          obscureText: true,
                          errorMessage: _getCreatePasswordErrorMessage(state,context),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InputTextField(
                          localized(context).confirmPassword,
                          controller: passwordConfirmTextFieldController,
                          hintText: localized(context).confPasswordHint,
                          onChanged: () {
                            passwordMatchingResetTimer(context);
                          },
                          obscureText: true,
                          errorMessage: _getConfirmPasswordErrorMessage(state,context),
                        ),
                      ],
                    ),
                    const Spacer(),
                    DarkButton(
                      localized(context).createAccountButton,
                      onPressed: (state is! AuthenticationErrorState) &&
                              allFieldFilled()
                          ? () {
                              context.read<AuthenticationBloc>().add(
                                  CreateAccountClicked(
                                      emailTextFieldController.text,
                                      passwordTextFieldController.text));
                            }
                          : null,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.069,
                    ),
                    if (state is AuthenticationUnattendedError) ...{
                      RedErrorMessage(localized(context).unattendedError),
                    },
                    if (state is AuthenticationOperationNotAllowed) ...{
                      RedErrorMessage(localized(context).operationNotAllowed),
                    },
                  ],
                ),
              );
            },
          )),
    );
  }

  startEmailValidationTimer(BuildContext context) {
    _emailValidationTypingTimer =
        Timer(const Duration(milliseconds: textfieldCheckTime), () {
      context
          .read<AuthenticationBloc>()
          .add(EmailTypingStopped(emailTextFieldController.text));
    });
  }

  emailValidationResetTimer(BuildContext context) {
    context.read<AuthenticationBloc>().add(TypingStarted());
    _emailValidationTypingTimer?.cancel();
    startEmailValidationTimer(context);
  }

  startPasswordValidationTimer(BuildContext context) {
    _passwordValidationTypingTimer =
        Timer(const Duration(milliseconds: textfieldCheckTime), () {
      context
          .read<AuthenticationBloc>()
          .add(PasswordTypingStopped(passwordTextFieldController.text));
    });
  }

  passwordValidationResetTimer(BuildContext context) {
    context.read<AuthenticationBloc>().add(TypingStarted());
    _passwordValidationTypingTimer?.cancel();
    startPasswordValidationTimer(context);
  }

  startPasswordMatchingTimer(BuildContext context) {
    _passwordMatchingTypingTimer =
        Timer(const Duration(milliseconds: textfieldCheckTime), () {
      context.read<AuthenticationBloc>().add(PasswordConfirmationTypingStopped(
          passwordTextFieldController.text,
          passwordConfirmTextFieldController.text));
    });
  }

  passwordMatchingResetTimer(BuildContext context) {
    context.read<AuthenticationBloc>().add(TypingStarted());
    _passwordMatchingTypingTimer?.cancel();
    startPasswordMatchingTimer(context);
  }

  bool allFieldFilled() {
    if (emailTextFieldController.text != "" &&
        passwordTextFieldController.text != "" &&
        passwordConfirmTextFieldController.text != "") return true;

    return false;
  }

  String _getEmailAdressErrorMessage(AuthenticationState state,BuildContext context) {
    if (state is AuthenticationInvalidEmail) return localized(context).invalidEmailErrorMesage;
    if (state is AuthenticationEmailAlreadyInUse) return localized(context).emailAlreadyInUseErrorMessage;
    return "";
  }

  String _getCreatePasswordErrorMessage(AuthenticationState state,BuildContext context) {
    if (state is AuthenticationInvalidPassword) {
      return localized(context).badPasswordErrorMessage;
    }
    if (state is AuthenticationWeakPassword) {
      return localized(context).weakPasswordErrorMessage;
    }

    return "";
  }

  String _getConfirmPasswordErrorMessage(AuthenticationState state,BuildContext context) {
    if (state is AuthenticationNotMatchingPassword) {
      return localized(context).passwordNotMatchingErrorMessage;
    }

    return "";
  }
}
