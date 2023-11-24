import 'package:firebase_auth/firebase_auth.dart';
import 'package:ubee_mini/features/authentication/data/model/create_user_response.dart';

abstract class UserApi{
  UserCredential? getUserCredential();

  CreateUserResponse createUser(String email, String password);
}