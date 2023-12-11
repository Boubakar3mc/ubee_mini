import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/utils/usecase.dart';
import 'package:ubee_mini/features/signin/data/model/update_user_response.dart';
import 'package:ubee_mini/features/signin/domain/entity/user_entity.dart';
import 'package:ubee_mini/features/signin/domain/repository/user_repository.dart';

class UpdateUser extends UseCase<UpdateUserResponse,UpdateUserParams>{
  final UserRepository repo;
  
  UpdateUser(this.repo);

  @override
  Future<UpdateUserResponse> call(UpdateUserParams params) {
    User user = User(firstName: params.firstName,lastName: params.lastName, birthDate: params.birthDate,picture:params.picture);
    return repo.updateUser(user);
  }

}

class UpdateUserParams extends Equatable{
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final File picture;

  const UpdateUserParams(this.firstName,this.lastName,this.birthDate,this.picture);
  
  @override

  List<Object?> get props => [firstName,lastName,birthDate,picture];


}