import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';
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
            const SizedBox(
              height: 57,
            ),
            const Text(
              'Welcome to UBEE',
              style: TextStyle(
                  color: themeDarkColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 57,
            ),
            const Text(
              'Your account was successfully created.',
              style: TextStyle(
                  color: themeDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 94,
            ),
            const Image(image: AssetImage('images/account_circle.webp')),
            const SizedBox(
              height: 59,
            ),
            const Text('How do you intend to use UBEE?',
                style: TextStyle(
                    color: themeDarkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 18,
            ),
            RectangularButton('I need help', onPressed: (){

            }),
            const SizedBox(
              height: 14,
            ),
            RectangularButton('I want to work', onPressed: (){
              Navigator.pushNamed(context, route.setupProfile);
            }),
          ],
        ),
      ),
    );
  }
}
