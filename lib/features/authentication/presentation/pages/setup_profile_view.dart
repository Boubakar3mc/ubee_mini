import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/components/progress_app_bar.dart';
import 'package:ubee_mini/core/components/top_page_title.dart';
import 'package:ubee_mini/core/route/route.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';
import 'package:ubee_mini/core/utils/date_format.dart';
import 'package:ubee_mini/core/utils/localized.dart';
import 'package:ubee_mini/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/dark_button.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/input_text_field.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/red_error_message.dart';
import 'package:ubee_mini/injection_container.dart' as injection;

class SetupProfileView extends StatefulWidget {
  const SetupProfileView({super.key});

  @override
  State<SetupProfileView> createState() => _SetupProfileViewState();
}

class _SetupProfileViewState extends State<SetupProfileView> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  bool? conditionChecked = false;

  DateTime? birthDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injection.sl<AuthenticationBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ProgressAppBar(
          onArrowPressed: () {
            Navigator.pop(context);
          },
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationNamesBirthdateSucessfullyUpdated) {
              Navigator.pushNamed(context, addPicturePage);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopPageTitle(title: localized(context).setupYourProfile),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                      width: 325,
                      child: Text(
                        localized(context).informationProvidedDisplay,
                        style: const TextStyle(
                            color: themeDarkColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: InputTextField(
                    localized(context).yourFirstName,
                    controller: firstNameController,
                    onChanged: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputTextField(localized(context).yourLastName,
                      controller: lastNameController, onChanged: () {}),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextField(localized(context).yourBirthDate, readOnly: true,
                    onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: birthDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())
                      .then((value) => {
                            if (value != null)
                              {
                                birthDate = value,
                              },
                            context
                                .read<AuthenticationBloc>()
                                .add(BirthdateChanged(birthDate!)),
                            birthDateController.text = birthDate != null
                                ? DateFormat.dasheMMddyyyy(birthDate!)
                                : "",
                          });
                },
                    errorMessage: _getBirthDateErrorMessage(state),
                    controller: birthDateController,
                    onChanged: () {}),
                const SizedBox(
                  height: 100,
                ),
                Row(
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
                        child: SizedBox(
                            width: 214,
                            child: Text(
                             localized(context).disclaimer,
                              style:const TextStyle(
                                  color: themeDarkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ))),
                  ],
                ),
                const Spacer(),
                if (state is AuthenticationNotLogedIn) ...{
                  RedErrorMessage(localized(context).notLogedIn),
                },
                DarkButton(
                  localized(context).continueButton,
                  onPressed:
                      (state is! AuthenticationErrorState) && _allFieldFilled()
                          ? () {
                              context.read<AuthenticationBloc>().add(
                                  ContinueSetupProfileClicked(
                                      firstNameController.text,
                                      lastNameController.text,
                                      birthDate!));
                            }
                          : null,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
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

  bool _allFieldFilled() {
    if (firstNameController.text != "" &&
        lastNameController.text != "" &&
        birthDateController.text != "" &&
        conditionChecked!) return true;

    return false;
  }
}
