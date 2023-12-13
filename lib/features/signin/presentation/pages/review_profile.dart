import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/components/progress_app_bar.dart';
import 'package:ubee_mini/core/components/top_page_title.dart';
import 'package:ubee_mini/core/route/route.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';
import 'package:ubee_mini/core/utils/date_format.dart';
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

  DateTime? birthDate;
  bool loadedTimeElapsed = false; //Timer to wait for textfields initial value to be loaded

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
      listener: (context, state) {},
      builder: (context, state) {
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
                const TopPageTitle(title: "Review your profile"),
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
                                child: const Text("Change picture",
                                    style: TextStyle(
                                        color: themeLightBlueColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InputTextField(
                  "Your first name",
                  controller: firstNameController,
                  onChanged: () {},
                  initialValue: state.firstName,
                ),
                InputTextField(
                  "Your last name",
                  controller: lastNameController,
                  onChanged: () {},
                  initialValue: state.lastName,
                ),
                InputTextField(
                  "Your date of birth",
                  controller: birthDateController,
                  onChanged: () {},
                  initialValue: DateFormat.dasheMMddyyyy(state.birthDate),
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: birthDate ?? state.birthDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now())
                        .then((value) => {
                              if (value != null)
                                {
                                  birthDate = value,
                                },
                              context
                                  .read<SigninBloc>()
                                  .add(BirthdateChanged(birthDate!)),
                              birthDateController.text = birthDate != null
                                  ? DateFormat.dasheMMddyyyy(birthDate!)
                                  : "",
                            });
                  },
                  errorMessage: _getBirthDateErrorMessage(state),
                ),
                const Spacer(),
                const Text('Your profile details can be changed at anytime,',
                    style: TextStyle(
                        color: themeDarkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const Text('*except for your full name and date of birth*.',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                DarkButton("Confirm",
                    onPressed:
                        _allFieldFilled()&&!state.hasErrors()&&loadedTimeElapsed?(){}:null,),
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
