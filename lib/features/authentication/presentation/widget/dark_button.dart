import 'package:flutter/material.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';

class DarkButton extends StatelessWidget{
  final String text;
  final Function? onPressed;
  final double width;

  const DarkButton(this.text,{required this.onPressed,this.width = 325, super.key});

  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: width,
                child: ElevatedButton(
                  onPressed:
                      onPressed==null?null:(){onPressed?.call();},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeBlueColor,
                    disabledBackgroundColor: themeDisabledButtonColor,
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(color: themeLightColor),
                  ),
                ),
              );
  }

}