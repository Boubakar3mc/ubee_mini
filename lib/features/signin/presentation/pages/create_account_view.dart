import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/components/simple_app_bar.dart';
import 'package:ubee_mini/core/utils/localized.dart';
import 'package:ubee_mini/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:ubee_mini/features/signin/presentation/widget/dark_button.dart';
import 'package:ubee_mini/features/signin/presentation/widget/red_error_message.dart';
import 'package:ubee_mini/features/signin/presentation/widget/input_text_field.dart';
import 'package:ubee_mini/core/route/route.dart' as route;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: SimpleAppBar(localized(context).createAnAccount,
            onArrowPressed: () {}),
        body: BlocConsumer<SigninBloc, SignInState>(
          listener: (context, state) {
            if (state.signInStateStatus == SignInStateStatus.userSuccessfullyCreated) {
              context.read<SigninBloc>().add(ChangingPage());
              Navigator.pushNamed(context, route.welcomePage);
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.055,
                  ),
                  Column(
                    children: [
                      InputTextField(
                        localized(context).enterEmailAdress,
                        controller: emailTextFieldController,
                        hintText: localized(context).emailHint,
                        onChanged: () {},
                        onTypingEnd: () {
                          context.read<SigninBloc>().add(
                              EmailTypingStopped(
                                  emailTextFieldController.text));
                        },
                        errorMessage:
                            _getEmailAdressErrorMessage(state, context),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InputTextField(
                        localized(context).createPassword,
                        controller: passwordTextFieldController,
                        onChanged: () {},
                        onTypingEnd: () {
                          context.read<SigninBloc>().add(
                              PasswordTypingStopped(
                                  passwordTextFieldController.text,
                                  passwordConfirmTextFieldController.text));
                        },
                        hintText: localized(context).passwordHint,
                        obscureText: true,
                        errorMessage:
                            _getCreatePasswordErrorMessage(state, context),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InputTextField(
                        localized(context).confirmPassword,
                        controller: passwordConfirmTextFieldController,
                        hintText: localized(context).confPasswordHint,
                        onChanged: () {},
                        onTypingEnd: () {
                          context.read<SigninBloc>().add(
                              PasswordTypingStopped(
                                  passwordTextFieldController.text,
                                  passwordConfirmTextFieldController.text));
                        },
                        obscureText: true,
                        errorMessage:
                            _getConfirmPasswordErrorMessage(state, context),
                      ),
                    ],
                  ),
                  const Spacer(),
                  DarkButton(
                    localized(context).createAccountButton,
                    onPressed: (!state.hasErrors()) &&
                            allFieldFilled()
                        ? () {
                            context.read<SigninBloc>().add(
                                CreateAccountClicked(
                                    emailTextFieldController.text,
                                    passwordTextFieldController.text));
                          }
                        : null,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.069,
                  ),
                  if (state.hasError(SignInStateError.unattendedError)) ...{
                    RedErrorMessage(localized(context).unattendedError),
                  },
                  if (state.hasError(SignInStateError.operationNotAllowed)) ...{
                    RedErrorMessage(localized(context).operationNotAllowed),
                  },
                ],
              ),
            );
          },
        ));
  }

  bool allFieldFilled() {
    if (emailTextFieldController.text != "" &&
        passwordTextFieldController.text != "" &&
        passwordConfirmTextFieldController.text != "") return true;

    return false;
  }

  String _getEmailAdressErrorMessage(
      SignInState state, BuildContext context) {
    if (state.signInStateStatus == SignInStateStatus.error && state.hasError(SignInStateError.invalidEmail)){
      return localized(context).invalidEmailErrorMesage;
    }
      
    if (state.signInStateStatus == SignInStateStatus.error && state.hasError(SignInStateError.emailAlreadyInUse)){
      return localized(context).emailAlreadyInUseErrorMessage;
    }
    return "";
  }

  String _getCreatePasswordErrorMessage(
      SignInState state, BuildContext context) {
    if (state.hasError(SignInStateError.invalidPassword)) {
      return localized(context).badPasswordErrorMessage;
    }
    if (state.hasError(SignInStateError.weakPassword)) {
      return localized(context).weakPasswordErrorMessage;
    }

    return "";
  }

  String _getConfirmPasswordErrorMessage(
      SignInState state, BuildContext context) {
    if (state.hasError(SignInStateError.notMatichingPassword)) {
      return localized(context).passwordNotMatchingErrorMessage;
    }

    return "";
  }
}
