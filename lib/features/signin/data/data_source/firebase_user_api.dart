import 'dart:io';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ubee_mini/features/signin/data/model/create_user_response.dart';
import 'package:ubee_mini/features/signin/data/model/update_names_and_birthdate_response.dart';
import 'package:ubee_mini/features/signin/data/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class UserApi{
  Future<CreateUserResponse> createUser(String email, String password);
  Future<UpdateNamesAndBirthdateResponse> updateNamesAndBirthdate(UserModel user);

  Future<bool> updatePicture(File file);
}

class FireBaseUserApi implements UserApi {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<CreateUserResponse> createUser(String email, String password) async{
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      CreateUserResponse createUserResponse =
          CreateUserResponse(true, responseError: CreateUserResponseError.none);

      return Future.value(createUserResponse);

    } on FirebaseAuthException catch (e) {
      late CreateUserResponse createUserResponse;
      switch (e.code) {
        case "email-already-in-use":
          createUserResponse = CreateUserResponse(false,
              responseError: CreateUserResponseError.emailAlreadyInUse);
          break;
        case "invalid-email":
          createUserResponse = CreateUserResponse(false,
              responseError: CreateUserResponseError.invalidEmail);
          break;
        case "operation-not-allowed":
          createUserResponse = CreateUserResponse(false,
              responseError: CreateUserResponseError.operationNotAllowed);
          break;
        case "weak-password":
          createUserResponse = CreateUserResponse(false,
              responseError: CreateUserResponseError.weakPassword);
          break;
        default:
          createUserResponse = CreateUserResponse(false,
              responseError: CreateUserResponseError.none);
          break;
      }
      return Future.value(createUserResponse);
    } catch (e) {
      return Future.value(CreateUserResponse(false,
          responseError: CreateUserResponseError.none));
    }
  }

  @override
  Future<UpdateNamesAndBirthdateResponse> updateNamesAndBirthdate(UserModel userModel) {
    try {
        
        final String? userEmail = FirebaseAuth.instance.currentUser?.email;
        if(userEmail==null) {
        return Future.value(UpdateNamesAndBirthdateResponse(false,responseError: UpdateNamesAndBirthdateRepsonseError.notLogedIn));
        }
        
        FirebaseFirestore db = FirebaseFirestore.instance;
        db.collection('Users').doc(userEmail).set(userModel.toShapshot(),SetOptions(merge: true));

        return Future.value(UpdateNamesAndBirthdateResponse(true));
        
    } catch (e) {
        return Future.value(UpdateNamesAndBirthdateResponse(false,message: e.toString()));
    }
  }
  
  @override
  Future<bool> updatePicture(File file) {
    //TODO: à Implémenter
    return Future.value(false);
  }

}
