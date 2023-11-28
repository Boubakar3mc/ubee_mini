import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorMessage extends StatefulWidget{
  final String message;
  final bool condition;

  const ErrorMessage(this.message,{required this.condition,super.key});

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> {
  @override
  Widget build(BuildContext context) {
    if(widget.condition){
      return Text(
                  widget.message,
                  style: const TextStyle(color: Colors.red));
    }
    else{
      return Container();
    }
  }
}