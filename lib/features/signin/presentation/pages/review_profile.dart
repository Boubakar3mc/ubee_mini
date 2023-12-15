import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/components/progress_app_bar.dart';
import 'package:ubee_mini/core/components/top_page_title.dart';
import 'package:ubee_mini/core/route/route.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';
import 'package:ubee_mini/core/utils/date_format.dart';
import 'package:ubee_mini/core/utils/localized.dart';
import 'package:ubee_mini/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:ubee_mini/features/signin/presentation/widget/dark_button.dart';
import 'package:ubee_mini/features/signin/presentation/widget/input_text_field.dart';

class ReviewProfile extends StatefulWidget {
  const ReviewProfile({super.key});

  @override
  State<ReviewProfile> createState() => _ReviewProfileState();
}

class _ReviewProfileState extends State<ReviewProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  DateTime birthDate = DateTime.now();
  bool loadedTimeElapsed =
      false; //Timer to wait for textfields initial value to be loaded

  @override
  initState() {
    super.initState();
    Timer(
        const Duration(seconds: 1),
        () => setState(() {
              loadedTimeElapsed = true;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninBloc, SignInState>(
      listener: (context, state) {
        if (state.signInStateStatus ==
            SignInStateStatus.userSuccessfullyUpdated) {
          context.read<SigninBloc>().add(ChangingPage());
          Navigator.pushNamed(context, userSuccessfullyCreated);
        }
        if (state.signInStateStatus == SignInStateStatus.error){
          String errorMessage = "";
          switch(state.errors[0]){
            case SignInStateError.notLogedIn:
              errorMessage = localized(context).notLoggedInError;
              break;
            case SignInStateError.unauthorized:
              errorMessage = localized(context).unauthorizedError;
              break;
            case SignInStateError.retryLimitExceeded:
              errorMessage = localized(context).retryLimitExceededError;
            case SignInStateError.unknown:
            default:
              errorMessage = localized(context).unknownError;
               break;
          }

          final snackBar = SnackBar(content: Text(errorMessage),action: SnackBarAction(label: 'OK',onPressed: (){},),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        birthDate = state.birthDate;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const ProgressAppBar(
            currentPart: 4,
            noArrow: true,
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopPageTitle(title: localized(context).reviewProfile),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.054,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.83,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.144 / 2,
                        backgroundImage: Image.file(state.selectedImage).image,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("${state.firstName} ${state.lastName}",
                                style: const TextStyle(
                                    color: themeDarkColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                            TextButton(
                                onPressed: () {
                                  context
                                      .read<SigninBloc>()
                                      .add(ChangePictureClicked());
                                  Navigator.pushNamed(context, addPicturePage);
                                },
                                child: Text(
                                    localized(context).changePicutreButton,
                                    style: const TextStyle(
                                        color: themeLightBlueColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.05,
                        minHeight: MediaQuery.of(context).size.height * 0.03)),
                InputTextField(
                  localized(context).firstName,
                  controller: firstNameController,
                  onChanged: () {},
                  initialValue: state.firstName,
                ),
                InputTextField(
                  localized(context).lastName,
                  controller: lastNameController,
                  onChanged: () {},
                  initialValue: state.lastName,
                ),
                InputTextField(
                  localized(context).birthday,
                  readOnly: true,
                  controller: birthDateController,
                  onChanged: () {},
                  initialValue: DateFormat.dasheMMddyyyy(birthDate),
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: birthDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now())
                        .then((value) => {
                              if (value != null)
                                {
                                  birthDate = value,
                                },
                              context
                                  .read<SigninBloc>()
                                  .add(BirthdateChanged(birthDate)),
                              birthDateController.text =
                                  DateFormat.dasheMMddyyyy(birthDate),
                            });
                  },
                  errorMessage: _getBirthDateErrorMessage(state),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.08,
                        maxHeight: MediaQuery.of(context).size.height * 0.10)),
                Text(localized(context).profileDetailsCanBeChanged,
                    style: const TextStyle(
                        color: themeDarkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Text(localized(context).except,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const Spacer(),
                DarkButton(
                  localized(context).confirmButton,
                  onPressed: _allFieldFilled() &&
                          !state.hasErrors() &&
                          loadedTimeElapsed
                      ? () {
                          context.read<SigninBloc>().add(ConfirmButtonClicked(
                              firstNameController.text,
                              lastNameController.text,
                              birthDate,
                              state.selectedImage));
                        }
                      : null,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _getBirthDateErrorMessage(SignInState state) {
    if (state.hasError(SignInStateError.invalidAge)) {
      return "You must be of legal age to proceed.";
    }
    return "";
  }

  bool _allFieldFilled() {
    return firstNameController.text != "" &&
        lastNameController.text != "" &&
        birthDateController.text != "";
  }
}
