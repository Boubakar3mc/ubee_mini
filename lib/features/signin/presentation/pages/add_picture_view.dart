import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/components/progress_app_bar.dart';
import 'package:ubee_mini/core/components/top_page_title.dart';
import 'package:ubee_mini/core/route/route.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';
import 'package:ubee_mini/core/utils/localized.dart';
import 'package:ubee_mini/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:ubee_mini/features/signin/presentation/widget/expandable_card.dart';
import 'package:ubee_mini/features/signin/presentation/widget/small_border_button.dart';

class AddPictureView extends StatefulWidget {
  const AddPictureView({super.key});

  @override
  State<AddPictureView> createState() => _AddPictureViewState();
}

class _AddPictureViewState extends State<AddPictureView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SignInState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: ProgressAppBar(
            onArrowPressed: () {
              state.signInStateStatus==SignInStateStatus.pictureSelected?
              context.read<SigninBloc>().add(ChangePictureClicked()):
              Navigator.pop(context);
            },
            currentPart: 3,
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TopPageTitle(
                      title: state.signInStateStatus ==
                              SignInStateStatus.pictureSelected
                          ? localized(context).lookingGreat
                          : localized(context).addProfilePicture),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.012,
                  ),
                  if (state.signInStateStatus !=
                      SignInStateStatus.pictureSelected) ...{
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        localized(context).showProfessionalLook,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeDarkColor),
                      ),
                    ),
                  },
                  SizedBox(
                    height: state.signInStateStatus ==
                            SignInStateStatus.pictureSelected
                        ? MediaQuery.of(context).size.height * 0.12
                        : MediaQuery.of(context).size.height * 0.055,
                  ),
                  if (state.signInStateStatus ==
                      SignInStateStatus.initial) ...{
                    const Image(image: AssetImage('images/add_a_photo.webp')),
                  },
                  if (state.signInStateStatus ==
                      SignInStateStatus.pictureSelected) ...{
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.48 / 2,
                      backgroundImage: Image.file(
                        state.selectedImage,
                      ).image,
                    )
                  },
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.037,
                  ),
                  if (state.signInStateStatus !=
                      SignInStateStatus.pictureSelected) ...{
                    ExpandableCard(
                      title: localized(context).picGuidelines,
                      texts: [
                        localized(context).bestSmile,
                        localized(context).centerYourself,
                        localized(context).makeFaceVisible,
                      ],
                    ),
                  },
                  if (state.signInStateStatus !=
                      SignInStateStatus.pictureSelected) ...{
                    const Spacer(),
                    SmallBorderButton(
                      text: localized(context).selectFromLibraryButton,
                      color: themeLightBlueColor,
                      onPressed: () {
                        context
                            .read<SigninBloc>()
                            .add(SelectImageFromLibraryClicked());
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    SmallBorderButton(
                      text: localized(context).goToCameraButton,
                      color: themeDarkColor,
                      onPressed: () {
                        context
                            .read<SigninBloc>()
                            .add(TakeImageWithCameraClicked());
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.074,
                    )
                  },
                  if (state.signInStateStatus ==
                      SignInStateStatus.pictureSelected) ...{
                    const Spacer(),
                    SmallBorderButton(
                      text: localized(context).changePicutreButton,
                      color: themeLightBlueColor,
                      onPressed: () {
                        context
                            .read<SigninBloc>()
                            .add(ChangePictureClicked());
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    SmallBorderButton(
                      text: localized(context).continueButton,
                      color: themeDarkColor,
                      onPressed: () {
                        context.read<SigninBloc>().add(ChangingPage());
                        Navigator.pushNamed(context, reviewProfilePage);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.074,
                    )
                  },
                ]),
          ),
        );
      },
    );
  }
}
