import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/components/progress_app_bar.dart';
import 'package:ubee_mini/core/components/top_page_title.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';
import 'package:ubee_mini/core/utils/localized.dart';
import 'package:ubee_mini/features/signin/presentation/bloc/signin_bloc.dart';
import 'package:ubee_mini/features/signin/presentation/widget/expandable_card.dart';
import 'package:ubee_mini/injection_container.dart' as injection;

class AddPictureView extends StatefulWidget {
  const AddPictureView({super.key});

  @override
  State<AddPictureView> createState() => _AddPictureViewState();
}

class _AddPictureViewState extends State<AddPictureView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injection.sl<SigninBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ProgressAppBar(
          onArrowPressed: () {
            Navigator.pop(context);
          },
          currentPart: 3,
        ),
        body: BlocConsumer<SigninBloc, SignInState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TopPageTitle(title: localized(context).addProfilePicture),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.012,
                    ),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,
                    ),
                    if (state.signInStateStatus == SignInStateStatus.initial) ...{
                      const Image(image: AssetImage('images/add_a_photo.webp')),
                    },
                    if (state.signInStateStatus == SignInStateStatus.pictureSelected) ...{
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
                    ExpandableCard(
                      title: localized(context).picGuidelines,
                      texts: [
                        localized(context).bestSmile,
                        localized(context).centerYourself,
                        localized(context).makeFaceVisible,
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.592,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: OutlinedButton(
                          //Select from library button
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 2.0, color: themeLightBlueColor)),
                          onPressed: () {
                            context.read<SigninBloc>().add(SelectImageFromLibraryClicked());
                          },
                          child: Text(
                              localized(context).selectFromLibraryButton,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: themeLightBlueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.592,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: OutlinedButton(
                          //Go to camera button
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 2.0, color: themeDarkColor)),
                          onPressed: () {
                            context.read<SigninBloc>().add(TakeImageWithCameraClicked());
                          },
                          child: Text(localized(context).goToCameraButton,
                              style: const TextStyle(
                                  color: themeDarkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.074,
                    )
                  ]),
            );
          },
        ),
      ),
    );
  }
}
