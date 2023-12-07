
import 'dart:io';

import 'package:ubee_mini/features/authentication/data/data_source/firebase_user_api.dart';
import 'package:ubee_mini/features/authentication/data/model/create_user_response.dart';
import 'package:ubee_mini/features/authentication/data/model/update_names_and_birthdate_response.dart';
import 'package:ubee_mini/features/authentication/data/model/user_model.dart';
import 'package:ubee_mini/features/authentication/domain/entity/user_entity.dart';
import 'package:ubee_mini/features/authentication/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  final UserApi userApi;

  UserRepositoryImpl(this.userApi);

  @override
  Future<CreateUserResponse> createUser(String email, String password) {
    return userApi.createUser(email, password);
  }

  @override
  Future<UpdateNamesAndBirthdateResponse> updateNamesAndBirthdate(User user) {
    return userApi.updateNamesAndBirthdate(UserModel.fromEntity(user));
  }

  @override
  Future<bool> updatePicture(File file) {
    return userApi.updatePicture(file);
  }

  

  
}