import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/utils/usecase.dart';


class PasswordMatchCheck extends UseCase<bool,PasswordMathcCheckParams>{
  @override
  Future<bool> call(PasswordMathcCheckParams params) {
    return Future.value(params.password == params.passwordConfirm);
  }

}

class PasswordMathcCheckParams extends Equatable{
  final String password;
  final String passwordConfirm;

  const PasswordMathcCheckParams(this.password,this.passwordConfirm);
  
  @override
  List<Object?> get props => [password,passwordConfirm];
}