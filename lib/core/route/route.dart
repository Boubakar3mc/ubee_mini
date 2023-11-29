import 'package:flutter/material.dart';
import 'package:ubee_mini/features/authentication/presentation/pages/welcom_to_ubee_view.dart';
import 'package:ubee_mini/features/job/presentation/pages/home.dart';

// Route Names

// Auth
const String authPage = 'auth';
const String welcomePage = 'welcome';


// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case authPage:
      return MaterialPageRoute(builder: (context) => const Home());
    case welcomePage:
      return MaterialPageRoute(builder: (context) => const WelcomeToUbeeView());
    default:
      return MaterialPageRoute(builder: (context) => Container());
  }
}

