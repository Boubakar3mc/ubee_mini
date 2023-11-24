import 'package:ubee_mini/features/authentication/data/data_source/user_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ubee_mini/features/authentication/data/model/create_user_response.dart';

class FireBaseUserApi implements UserApi{
  late UserCredential? userCredential;
  @override
  CreateUserResponse createUser(String email, String password){
    try {
      userCredential = FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      

     
    }
    on FirebaseAuthException catch (e){
      late CreateUserResponse createUserResponse;
      switch (e.code) {
        case "email-already-in-use":
          createUserResponse = CreateUserResponse(false,responseError:CreateUserResponseError.emailAlreadyInUse);
          break;
        case "invalid-email":
          createUserResponse = CreateUserResponse(false,responseError:CreateUserResponseError.invalidEmail);
          break;
        case "operation-not-allowed":
          createUserResponse = CreateUserResponse(false,responseError:CreateUserResponseError.operationNotAllowed);
          break;
        case "weak-password":
          createUserResponse = CreateUserResponse(false,responseError:CreateUserResponseError.weakPassword);
          break;
        default:
          createUserResponse = CreateUserResponse(false,responseError:CreateUserResponseError.none);
          break;
      }
      return createUserResponse;
    }
    catch (e) {
      return CreateUserResponse(false,responseError:CreateUserResponseError.none);
    }
     
  }
   

  @override
  UserCredential? getUserCredential() {
    return userCredential;
  }
  
}