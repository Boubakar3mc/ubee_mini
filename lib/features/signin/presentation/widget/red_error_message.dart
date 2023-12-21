import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RedErrorMessage extends StatefulWidget {
  final String message;

  const RedErrorMessage(this.message, {super.key});

  @override
  State<RedErrorMessage> createState() => _RedErrorMessageState();
}

class _RedErrorMessageState extends State<RedErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.message, style: const TextStyle(color: Colors.red));
  }
}
