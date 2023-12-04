import 'package:ubee_mini/features/authentication/data/model/create_user_response.dart';
import 'package:ubee_mini/features/authentication/data/model/update_names_and_birthdate_response.dart';

abstract class UserRepository{
  Future<CreateUserResponse> createUser(String email, String password);
  Future<UpdateNamesAndBirthdateResponse> updateNamesAndBirthdate(String firstName, String lastName, DateTime birthDate);
}
