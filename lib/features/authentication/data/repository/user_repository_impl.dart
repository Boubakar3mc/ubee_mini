import 'package:firebase_auth/firebase_auth.dart';
import 'package:ubee_mini/features/authentication/data/data_source/user_api.dart';
import 'package:ubee_mini/features/authentication/data/model/create_user_response.dart';
import 'package:ubee_mini/features/authentication/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  final UserApi userApi;

  UserRepositoryImpl(this.userApi);

  @override
  CreateUserResponse createUser(String email, String password) {
    return userApi.createUser(email, password);
  }


  @override
  UserCredential? getUseCredential() => userApi.getUserCredential();
  
}