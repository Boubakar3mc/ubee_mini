import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/use_cases.dart';

class PasswordMatchCheck extends UseCases<bool,PasswordMathcCheckParams>{
  @override
  bool call(PasswordMathcCheckParams params) {
    return params.password == params.passwordConfirm;
  }

}

class PasswordMathcCheckParams extends Equatable{
  final String password;
  final String passwordConfirm;

  const PasswordMathcCheckParams(this.password,this.passwordConfirm);
  
  @override
  List<Object?> get props => [password,passwordConfirm];
}