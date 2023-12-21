import 'package:flutter/material.dart';
import 'package:ubee_mini/features/signin/presentation/pages/add_picture_view.dart';
import 'package:ubee_mini/features/signin/presentation/pages/create_account_view.dart';
import 'package:ubee_mini/features/signin/presentation/pages/review_profile.dart';
import 'package:ubee_mini/features/signin/presentation/pages/setup_profile_view.dart';
import 'package:ubee_mini/features/signin/presentation/pages/user_successfully_created.dart';
import 'package:ubee_mini/features/signin/presentation/pages/welcom_to_ubee_view.dart';

// Route Names

// Auth
const String createAccount = 'createAccount';
const String welcomePage = 'welcome';
const String setupProfilePage = 'setupProfile';
const String addPicturePage = "addPicture";
const String reviewProfilePage = "reviewProfile";
const String userSuccessfullyCreated = "userCreated";


// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case createAccount:
      return MaterialPageRoute(builder: (context) => CreateAccountView());
    case welcomePage:
      return MaterialPageRoute(builder: (context) => const WelcomeToUbeeView());
    case setupProfilePage:
      return MaterialPageRoute(builder: (context) => const SetupProfileView());
    case addPicturePage:
      return MaterialPageRoute(builder: (context) => const AddPictureView());
    case reviewProfilePage:
      return MaterialPageRoute(builder: (context) => const ReviewProfile());
    case userSuccessfullyCreated:
      return MaterialPageRoute(builder: (context) => const UserSuccessfullyCreated());
    default:
      return MaterialPageRoute(builder: (context) => Container());
  }
}

