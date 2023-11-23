import 'package:flutter/material.dart';
import 'package:ubee_mini/core/utils/localized.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(localized(context).appName),
      ),
    );
  }
}
