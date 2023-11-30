import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';

class InputTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final Function onChanged;
  final bool obscureText;

  const InputTextField(this.labelText,
      {required this.controller,
      required this.onChanged,
      this.hintText = "",
      this.obscureText = false,
      super.key});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(context) {
    return SizedBox(
      width: 250,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          label: Text(
            widget.labelText,
            style: const TextStyle(
                color: themeBlueColor,
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                height: 1.5),
          ),
          hintText: widget.hintText,
        ),
        obscureText: widget.obscureText,
        onChanged: (text) {
          widget.onChanged.call();
        },
      ),
    );
  }
}
