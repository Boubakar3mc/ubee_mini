import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/utils/usecase.dart';

class EmailValidation extends UseCase<bool,EmailValidationParams>{
  @override
  Future<bool> call(EmailValidationParams params) {

    return Future.value(EmailValidator.validate(params.email));
  }

}

class EmailValidationParams extends Equatable{
  final String email;

  const EmailValidationParams(this.email);

  @override
  List<Object?> get props => [email];
  
}