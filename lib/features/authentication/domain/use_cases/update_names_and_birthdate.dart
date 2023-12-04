import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/utils/usecase.dart';
import 'package:ubee_mini/features/authentication/data/model/update_names_and_birthdate_response.dart';
import 'package:ubee_mini/features/authentication/domain/repository/user_repository.dart';

class UpdateNamesAndBirthdate extends UseCase<UpdateNamesAndBirthdateResponse,UpdateNamesAndBirthdateParams>{
  final UserRepository repo;
  
  UpdateNamesAndBirthdate(this.repo);

  @override
  Future<UpdateNamesAndBirthdateResponse> call(UpdateNamesAndBirthdateParams params) {
    return repo.updateNamesAndBirthdate(params.firstName, params.lastName, params.birthDate);
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