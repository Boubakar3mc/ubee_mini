import 'dart:io';

import 'package:ubee_mini/features/signin/data/model/create_user_response.dart';
import 'package:ubee_mini/features/signin/data/model/update_user_response.dart';
import 'package:ubee_mini/features/signin/domain/entity/user_entity.dart';

abstract class UserRepository{
  Future<CreateUserResponse> createUser(String email, String password);
  Future<UpdateUserResponse> updateUser(User user);
}
