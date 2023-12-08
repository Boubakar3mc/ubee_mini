import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/user_entity.dart';

class UserModel extends User{
  UserModel(firstName,lastName,birthDate) : super(firstName: firstName, lastName: lastName, birthDate: birthDate);
  
 factory UserModel.fromSnapshot(DocumentSnapshot snapshot){
    return UserModel(snapshot['firstName'],snapshot['lastName'],snapshot['birthDate']);
  }

  Map<String,dynamic> toShapshot(){
    return  {'firstName': firstName,
          'lastName': lastName,
          'birthDate' : birthDate,};
  }

  factory UserModel.fromEntity(User user){
    return UserModel(user.firstName, user.lastName,user.birthDate);
  }

}