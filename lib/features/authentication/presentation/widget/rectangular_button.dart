import 'package:flutter/material.dart';
import 'package:ubee_mini/core/utils/constants.dart';

class RectangularButton extends StatelessWidget{
  final String text;
  final Function? onPressed; // Set to null for disabled button

  const RectangularButton(this.text,{required this.onPressed,super.key});

  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: 325,
              child: ElevatedButton(
                  onPressed: onPressed==null?null:(){onPressed?.call();},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20.0))
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(text,
                          style: const TextStyle(
                              color: themeLightBlueColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400)),
                      const Icon(Icons.arrow_forward_outlined,color: themeBlueColor,)
                    ],
                  )),
            );
  }

}