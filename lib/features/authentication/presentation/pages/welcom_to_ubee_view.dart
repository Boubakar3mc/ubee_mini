import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ubee_mini/core/utils/constants.dart';

class WelcomeToUbeeView extends StatefulWidget{
  const WelcomeToUbeeView({super.key});

  @override
  State<WelcomeToUbeeView> createState() => _WelcomeToUbeeViewState();
}

class _WelcomeToUbeeViewState extends State<WelcomeToUbeeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 57,
            ),
            Text('Welcome to UBEE',style: TextStyle(color: themeDarkColor,fontSize: 28,fontWeight: FontWeight.w600),),
            SizedBox(
              height: 57,
            ),
            Text('Your account was successfully created.', style: TextStyle(color:themeDarkColor,fontSize: 18,fontWeight: FontWeight.w600),),
            SizedBox(
              height: 94,
            ),
            
          ],
        ),
      ),
    );
  }
}