import 'package:flutter/material.dart';
import 'package:ubee_mini/core/components/progress_app_bar.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';

class SetupProfile extends StatefulWidget {
  const SetupProfile({super.key});

  @override
  State<SetupProfile> createState() => _SetupProfileState();
}

class _SetupProfileState extends State<SetupProfile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ProgressAppBar(),
      body: Column(
        children: [
          Text('Setup your profile',style: TextStyle(color: themeDarkColor,fontSize: 28,fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }

  
}
