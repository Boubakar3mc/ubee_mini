import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ubee_mini/core/utils/date_format.dart';
import 'package:ubee_mini/features/signin/data/model/create_user_response.dart';
import 'package:ubee_mini/features/signin/data/model/update_user_response.dart';
import 'package:ubee_mini/features/signin/data/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class UserApi {
  Future<CreateUserResponse> createUser(String email, String password);
  Future<UpdateUserResponse> updateUser(UserModel user);
}

class FireBaseUserApi implements UserApi {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<CreateUserResponse> createUser(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

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
  Future<UpdateUserResponse> updateUser(UserModel userModel) async {
    try {
      final String? userEmail = FirebaseAuth.instance.currentUser?.email;
      if (userEmail == null) {
        return Future.value(UpdateUserResponse(false,
            responseError: UpdateUserResponseError.notLogedIn));
      }

      final storageRef = FirebaseStorage.instance.ref();

      final String ext = extension(userModel.picture.path);
      final String fileName = userModel.firstName + DateFormat.forFileUniqueness(DateTime.now()) + ext;

      
      final pictureRef =
          storageRef.child("user_image/$fileName");

      await pictureRef.putFile(userModel.picture);
      String downloadURL = await pictureRef.getDownloadURL();

      FirebaseFirestore db = FirebaseFirestore.instance;
      db
          .collection('Users')
          .doc(userEmail)
          .set(userModel.toShapshot(downloadURL), SetOptions(merge: true));

      return Future.value(UpdateUserResponse(true));
    } on FirebaseException catch (e) {
      UpdateUserResponse updateUserResponse;
      switch (e.code) {
        case "storage/unknown":
          updateUserResponse = UpdateUserResponse(false,
              responseError: UpdateUserResponseError.unknown);
          break;
        case "storage/unauthenticated":
          updateUserResponse = UpdateUserResponse(false,
              responseError: UpdateUserResponseError.notLogedIn);
          break;
        case "storage/retry-limit-exceeded":
          updateUserResponse = UpdateUserResponse(false,
              responseError: UpdateUserResponseError.retryLimitExceeded);
          break;
        default:
          updateUserResponse = UpdateUserResponse(false,
              responseError: UpdateUserResponseError.unknown);
      }
      return updateUserResponse;
    } catch (e) {
      return Future.value(UpdateUserResponse(false, message: e.toString()));
    }
  }
}
