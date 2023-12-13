import 'package:flutter/material.dart';

class SmallBorderButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressed;

  const SmallBorderButton({required this.text, required this.color,required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.592,
      height: MediaQuery.of(context).size.height * 0.06,
      child: OutlinedButton(
          //Go to camera button
          style: OutlinedButton.styleFrom(
              side: BorderSide(width: 2.0, color: color)),
          onPressed: () {
             onPressed.call();
          },
          child: Text(text,
              style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600))),
    );
  }
}
