import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/utils/usecase.dart';

class PasswordValidation extends UseCase<bool,PasswordValidationParams>{
  @override
  Future<bool> call(PasswordValidationParams params) {

    //J'ai choisis les règles suivante pour la validation du mot de passe:
      // - Au moins une lettre majuscule
      // - Au moins une lettre minuscule
      // - Au moins un chiffre
      // - Au moins un caractère spéciaux (!@#\$&*~%)

    RegExp validationRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%]).{8,}$'); 

    RegExpMatch? match = validationRegex.firstMatch(params.password);
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