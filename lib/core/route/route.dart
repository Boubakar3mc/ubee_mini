import 'package:flutter/material.dart';
import 'package:ubee_mini/features/authentication/presentation/pages/add_picture_view.dart';
import 'package:ubee_mini/features/authentication/presentation/pages/create_account_view.dart';
import 'package:ubee_mini/features/authentication/presentation/pages/setup_profile_view.dart';
import 'package:ubee_mini/features/authentication/presentation/pages/welcom_to_ubee_view.dart';

// Route Names

// Auth
const String authPage = 'auth';
const String welcomePage = 'welcome';
const String setupProfilePage = 'setupProfile';
const String addPicturePage = "addPicture";


// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case authPage:
      return MaterialPageRoute(builder: (context) => const CreateAccountView());
    case welcomePage:
      return MaterialPageRoute(builder: (context) => const WelcomeToUbeeView());
    case setupProfilePage:
      return MaterialPageRoute(builder: (context) => const SetupProfileView());
    case addPicturePage:
      return MaterialPageRoute(builder: (context) => const AddPictureView());
    default:
      return MaterialPageRoute(builder: (context) => Container());
  }
}

