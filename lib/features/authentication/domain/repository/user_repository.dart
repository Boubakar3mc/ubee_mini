import 'package:ubee_mini/features/authentication/data/model/create_user_response.dart';

abstract class UserRepository{
  Future<CreateUserResponse> createUser(String email, String password);
  
}
