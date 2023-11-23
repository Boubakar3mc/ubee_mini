import 'package:flutter/material.dart';
import 'package:ubee_mini/features/job/presentation/pages/home.dart';

// Route Names

// Auth
const String authPage = 'auth';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case authPage:
      return MaterialPageRoute(builder: (context) => const Home());
    default:
      return MaterialPageRoute(builder: (context) => Container());
  }
}
