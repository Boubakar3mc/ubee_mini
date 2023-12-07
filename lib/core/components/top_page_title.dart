import 'package:flutter/material.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';

class TopPageTitle extends StatelessWidget{
  final String title;

  const TopPageTitle({super.key,required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
              title,
              style:const TextStyle(
                  fontSize: 28,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  color: themeDarkColor),
            );
  }

}