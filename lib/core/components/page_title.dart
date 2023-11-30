import 'package:flutter/material.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final Function onArrowPressed;

  const PageTitle(this.title,{required this.onArrowPressed,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {onArrowPressed.call();},
            icon: const Icon(Icons.arrow_back, color: themeBlueColor)),
         Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 28,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                height: 1.2),
          ),
        ),
      ],
    );
  }
}
