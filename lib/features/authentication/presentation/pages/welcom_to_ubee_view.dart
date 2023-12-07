import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ubee_mini/core/components/top_page_title.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';
import 'package:ubee_mini/core/utils/localized.dart';
import 'package:ubee_mini/features/authentication/presentation/widget/rectangular_button.dart';
import 'package:ubee_mini/core/route/route.dart' as route;

class WelcomeToUbeeView extends StatefulWidget {
  const WelcomeToUbeeView({super.key});

  @override
  State<WelcomeToUbeeView> createState() => _WelcomeToUbeeViewState();
}

class _WelcomeToUbeeViewState extends State<WelcomeToUbeeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            TopPageTitle(title: localized(context).welcomeToUBEE),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Text(
              localized(context).accountSuccessfullyCreated,
              style: const TextStyle(
                  color: themeDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            const Image(image: AssetImage('images/account_circle.webp')),
            const SizedBox(
              height: 59,
            ),
            Text(localized(context).intendToUseUBEE,
                style: const TextStyle(
                    color: themeDarkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.022,
            ),
            RectangularButton(localized(context).iNeedHelpButton, onPressed: (){

            }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.017,
            ),
            RectangularButton(localized(context).iWantWorkButton, onPressed: (){
              Navigator.pushNamed(context, route.setupProfilePage);
            }),
          ],
        ),
      ),
    );
  }
}
