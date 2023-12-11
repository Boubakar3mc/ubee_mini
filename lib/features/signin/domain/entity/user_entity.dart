import 'dart:io';

import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final File picture;

  User({required this.firstName,required this.lastName, required this.birthDate, required this.picture});
  
  @override
  List<Object?> get props => [firstName,lastName,birthDate];
}