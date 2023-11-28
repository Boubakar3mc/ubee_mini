import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/utils/constants.dart';
import 'package:ubee_mini/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/errorMessage.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/inputTextField.dart';
import 'package:ubee_mini/injection_container.dart' as injection;
import 'dart:async';

class CreateAccountView extends StatefulWidget {
  final String title;

  const CreateAccountView(this.title, {super.key});

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
      child:
          Scaffold(body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(
                height: 58,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon:
                          const Icon(Icons.arrow_back, color: themeBlueColor)),
                  const Text(
                    'Create an account',
                    style: TextStyle(
                        fontSize: 28,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        height: 1.2),
                  ),
                ],
              ),
              Column(
                children: [
                  InputTextField(
                    'Enter your email address',
                    controller: emailTextFieldController,
                    hintText: 'Email',
                    onChanged: () {
                      emailValidationResetTimer(context);
                    },
                  ),
                  ErrorMessage('Invalid email adress', condition: state is AuthenticationInvalidEmail ),
                  ErrorMessage('Email already in use', condition: state is AuthenticationEmailAlreadyInUse),
                ],
              ),
              Column(
                children: [
                  InputTextField(
                    'Create a password',
                    controller: passwordTextFieldController,
                    onChanged: () {
                      passwordValidationResetTimer(context);
                    },
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  ErrorMessage("The password must have:\n At least 8 characters \n At least 1 UpperCase character\n At least 1 LowerCase character \n At least 1 number \n At least one Special Char(!@#\$&*~%)", condition: state is AuthenticationInvalidPassword),
                  ErrorMessage('Weak password. The password must have:\n At least 8 characters \n At least 1 UpperCase character\n At least 1 LowerCase character \n At least 1 number \n At least one Special Char(!@#\$&*~%)',condition:state is AuthenticationWeakPassword),
                ],
              ),
              Column(
                children: [
                  InputTextField(
                    'Confirm password',
                    controller: passwordConfirmTextFieldController,
                    hintText: 'Confirm password',
                    onChanged: () {
                      passwordMatchingResetTimer(context);
                    },
                    obscureText: true,
                  ),
                  ErrorMessage("Password doesn't match", condition: state is AuthenticationNotMatchingPassword)
                ],
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed:
                      (state is! AuthenticationErrorState) && allFieldFilled()
                          ? () {
                              context.read<AuthenticationBloc>().add(
                                  CreateAccountClicked(
                                      emailTextFieldController.text,
                                      passwordTextFieldController.text));
                            }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeBlueColor,
                    disabledBackgroundColor: themeDisabledButtonColor,
                  ),
                  child: const Text(
                    'Create account',
                    style: TextStyle(color: themeLightColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ErrorMessage('Unattended error', condition: state is AuthenticationUnattendedError),
              ErrorMessage('Operation not allowed', condition: state is AuthenticationOperationNotAllowed),
              ErrorMessage('Authentication successfull', condition: state is AuthenticationUserSuccessfullyCreated),
            ],
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
    _passwordMatchingTypingTimer?.cancel();
    startPasswordMatchingTimer(context);
  }

  bool allFieldFilled() {
    if (emailTextFieldController.text != "" &&
        passwordTextFieldController.text != "" &&
        passwordConfirmTextFieldController.text != "") return true;

    return false;
  }
}
