import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/utils/constants.dart';
import 'package:ubee_mini/features/authentication/presentation/bloc/authentication_bloc.dart';
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
                  SizedBox(
                    width: 250,
                    child: InputTextField(
                      'Enter your email address',
                      controller: emailTextFieldController,
                      hintText: 'Email',
                      onChanged: () {
                        emailValidationResetTimer(context);
                      },
                    ),
                  ),
                  (state is AuthenticationInvalidEmail)
                      ? const Text(
                          'Invalid email adress',
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                  (state is AuthenticationEmailAlreadyInUse)
                      ? const Text(
                          'Email already in use',
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                      width: 250,
                      child: InputTextField(
                        'Create a password',
                        controller: passwordTextFieldController,
                        onChanged: () {
                          passwordValidationResetTimer(context);
                        },
                        hintText: 'Password',
                        obscureText: true,
                      )),
                  (state is AuthenticationInvalidPassword)
                      ? const Text(
                          'The password must have:\n At least 8 characters \n At least 1 UpperCase character\n At least 1 LowerCase character \n At least 1 number \n At least one Special Char(!@#\$&*~%)',
                          style: TextStyle(color: Colors.red))
                      : Container(),
                  (state is AuthenticationWeakPassword)
                      ? const Text(
                          'Weak password. The password must have:\n At least 8 characters \n At least 1 UpperCase character\n At least 1 LowerCase character \n At least 1 number \n At least one Special Char(!@#\$&*~%)',
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                      width: 250,
                      child: InputTextField(
                        'Confirm password',
                        controller: passwordConfirmTextFieldController,
                        hintText: 'Confirm password',
                        onChanged: (){passwordMatchingResetTimer(context);},
                        obscureText: true,
                      )),
                  (state is AuthenticationNotMatchingPassword)
                      ? const Text(
                          "Password doesn't match",
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: (state is AuthenticationInitial) && allFieldFilled()
                    ? () {
                        context.read<AuthenticationBloc>().add(
                            CreateAccountClicked(emailTextFieldController.text,
                                passwordTextFieldController.text));
                      }
                    : null,
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(themeBlueColor)),
                child: const Text(
                  'Create account',
                  style: TextStyle(color: themeLightColor),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              (state is AuthenticationUnattendedError)
                  ? const Text('UnattendedError',
                      style: TextStyle(color: Colors.red))
                  : Container(),
              (state is AuthenticationOperationNotAllowed)
                  ? const Text('OperationNotAllowed',
                      style: TextStyle(color: Colors.red))
                  : Container(),
              (state is AuthenticationUserSuccessfullyCreated)
                  ? const Text('Authentication successfull',
                      style: TextStyle(color: Colors.red))
                  : Container(),
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
