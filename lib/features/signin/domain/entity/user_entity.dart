import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String firstName;
  final String lastName;
  final DateTime birthDate;

  User({required this.firstName,required this.lastName, required this.birthDate});
  
  @override
  List<Object?> get props => [firstName,lastName,birthDate];
}