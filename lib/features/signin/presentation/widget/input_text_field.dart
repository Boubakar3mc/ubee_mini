import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/core/utils/colors_constants.dart';
import 'package:ubee_mini/core/utils/constants.dart';
import 'package:ubee_mini/features/signin/presentation/bloc/signin_bloc.dart';

class InputTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final Function onChanged;
  final Function? onTypingEnd;
  final bool obscureText;
  final String errorMessage;
  final Function() ?onTap;
  final bool readOnly;
  final String initialValue;

  const InputTextField(this.labelText,
      {required this.controller,
      required this.onChanged,
      this.onTypingEnd,
      this.hintText = "",
      this.obscureText = false,
      this.errorMessage="",
      this.onTap,
      this.readOnly=false,
      this.initialValue = "",
      super.key});


  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  Timer? typingTimer;
  String lastValue = "";
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialValue;
  }

  @override
  Widget build(context) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          TextField(
            readOnly: widget.readOnly,
            onTap: widget.onTap,
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
              focusedBorder: widget.errorMessage!=""?const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)):null,
              suffixIcon: widget.errorMessage!=""?const Padding(
                padding: EdgeInsets.only(top:30),
                child: Icon(Icons.highlight_off,color:Colors.red),
              ):null,
            ),
            obscureText: widget.obscureText,
            onChanged: (text) {
              widget.onChanged.call();
              typpingResetTimer(context);
            },
          ),
          if(widget.errorMessage!="") _showError(),
        ],
      ),
    );
  }
  
  Widget _showError(){
    return Text("*${widget.errorMessage}",style: const TextStyle(color: Colors.red, fontSize: 14,fontWeight: FontWeight.w400));
  }

  startTyppingTimer(BuildContext context) {
    typingTimer =
        Timer(const Duration(milliseconds: textfieldCheckTime), () {
          widget.onTypingEnd?.call();
    });
  }

  typpingResetTimer(BuildContext context) {
    context.read<SigninBloc>().add(TypingStarted());
    typingTimer?.cancel();
    startTyppingTimer(context);
  }
}
