import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/use_cases.dart';
import 'package:ubee_mini/features/authentication/domain/repository/user_repository.dart';

class CreateUser extends UseCases<void,CreateUserParams>{
  final UserRepository repo;

  CreateUser(this.repo);
  @override
  void call(CreateUserParams params) {
    return repo.createUser(params.email, params.password);
  }

}

class CreateUserParams extends Equatable{
  final String email;
  final String password;
 

  const CreateUserParams(this.email,this.password);
  
  @override
  List<Object?> get props => [email,password];

}