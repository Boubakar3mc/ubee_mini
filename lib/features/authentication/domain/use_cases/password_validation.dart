import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/utils/constants.dart';
import 'package:ubee_mini/core/utils/usecase.dart';

class PasswordValidation extends UseCase<bool,PasswordValidationParams>{
  @override
  Future<bool> call(PasswordValidationParams params) {

    RegExpMatch? match = passwordValidationRegex.firstMatch(params.password);
    if(match!=null) return Future.value(true);

    return Future.value(false);
  }

}

class PasswordValidationParams extends Equatable{
  final String password;

  const PasswordValidationParams(this.password);

  @override
  List<Object?> get props => [password];

}