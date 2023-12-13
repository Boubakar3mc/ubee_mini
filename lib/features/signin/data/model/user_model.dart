import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/user_entity.dart';

class UserModel extends User{
  UserModel(firstName,lastName,birthDate,picture) : super(firstName: firstName, lastName: lastName, birthDate: birthDate,picture: picture );
  
 factory UserModel.fromSnapshot(DocumentSnapshot snapshot){
    return UserModel(snapshot['firstName'],snapshot['lastName'],snapshot['birthDate'],snapshot['picture']);
  }

  Map<String,dynamic> toShapshot(String downloadURL){
    return  {'firstName': firstName,
          'lastName': lastName,
          'birthDate' : birthDate,
          'dowloadURL' : downloadURL,};
  }

  factory UserModel.fromEntity(User user){
    return UserModel(user.firstName, user.lastName,user.birthDate, user.picture);
  }

}