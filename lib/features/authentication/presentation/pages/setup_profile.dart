import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/components/progress_app_bar.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';
import 'package:ubee_mini/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/dark_button.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/input_text_field.dart';
import 'package:ubee_mini/injection_container.dart' as injection;

class SetupProfile extends StatefulWidget {
  const SetupProfile({super.key});

  @override
  State<SetupProfile> createState() => _SetupProfileState();
}

class _SetupProfileState extends State<SetupProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  bool? conditionChecked = false;

  final FocusNode _focus = FocusNode();
  DateTime? birthDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injection.sl<AuthenticationBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const ProgressAppBar(),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  const Text(
                    'Setup your profile',
                    style: TextStyle(
                        color: themeDarkColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: SizedBox(
                        width: 325,
                        child: Text(
                          'The information you provided will displayed on your profile page.',
                          style: TextStyle(
                              color: themeDarkColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: InputTextField("What's your first name?",
                        controller: firstNameController, onChanged: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InputTextField("What's your last name?",
                        controller: lastNameController, onChanged: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InputTextField("What's your date of birth",
                        readOnly: true,
                        onTap:(){ showDatePicker(
                                    context: context,
                                    initialDate: birthDate ?? DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now()).then((value) => {
                                      
                                      if(value!=null){
                                        birthDate = value,
                                      },
                                      context.read<AuthenticationBloc>().add(BirthdateChanged(birthDate!)),
                                      birthDateController.text = birthDate != null
                                      ? "${birthDate?.month.toString().padLeft(2, '0')} - ${birthDate?.day.toString().padLeft(2, '0')} - ${birthDate?.year}"
                                      : "",
                                    });
                                    },
                        errorMessage: _getBirthDateErrorMessage(state),
                        controller: birthDateController,
                        onChanged: () {}),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: conditionChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              conditionChecked = value;
                            });
                          },
                          activeColor: const Color.fromARGB(255, 78, 145, 255),
                        ),
                        Flexible(
                            child: Container(
                                width: 214,
                                child: const Text(
                                  'I understand that I will be acting as an individual contractor within the UBEE organization.',
                                  style: TextStyle(
                                      color: themeDarkColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ))),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  DarkButton('Continue', onPressed: () {}),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _getBirthDateErrorMessage(AuthenticationState state) {
    if (state is AuthenticationInvalidAge) {
      return "You must be of legal age to proceed.";
    }
    return "";
  }
}
