import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/utils/usecase.dart';
import 'package:ubee_mini/features/signin/data/model/update_names_and_birthdate_response.dart';
import 'package:ubee_mini/features/signin/domain/entity/user_entity.dart';
import 'package:ubee_mini/features/signin/domain/repository/user_repository.dart';

class UpdateNamesAndBirthdate extends UseCase<UpdateNamesAndBirthdateResponse,UpdateNamesAndBirthdateParams>{
  final UserRepository repo;
  
  UpdateNamesAndBirthdate(this.repo);

  @override
  Future<UpdateNamesAndBirthdateResponse> call(UpdateNamesAndBirthdateParams params) {
    User user = User(firstName: params.firstName,lastName: params.lastName, birthDate: params.birthDate);
    return repo.updateNamesAndBirthdate(user);
  }

}

class UpdateNamesAndBirthdateParams extends Equatable{
  final String firstName;
  final String lastName;
  final DateTime birthDate;

  const UpdateNamesAndBirthdateParams(this.firstName,this.lastName,this.birthDate);
  
  @override

  List<Object?> get props => [firstName,lastName,birthDate];


}