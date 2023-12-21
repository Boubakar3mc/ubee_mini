import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/utils/usecase.dart';
import 'package:ubee_mini/features/signin/data/model/create_user_response.dart';
import 'package:ubee_mini/features/signin/domain/repository/user_repository.dart';

class CreateUser extends UseCase<CreateUserResponse,CreateUserParams>{
  final UserRepository repo;

  CreateUser(this.repo);
  
  @override
  Future<CreateUserResponse> call(CreateUserParams params) {
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