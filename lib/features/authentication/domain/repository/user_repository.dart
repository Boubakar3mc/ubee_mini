import 'package:ubee_mini/features/authentication/data/model/user.dart';

abstract class UserRepository{
  User getUser();

  void createUser(String email, String password);
  
}