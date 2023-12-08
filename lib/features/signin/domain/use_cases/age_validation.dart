import 'package:age_calculator/age_calculator.dart';
import 'package:equatable/equatable.dart';
import 'package:ubee_mini/core/utils/constants.dart';
import 'package:ubee_mini/core/utils/usecase.dart';

class AgeValidation extends UseCase<bool, AgeValidationParams>{
  @override
  Future<bool> call(AgeValidationParams params) {
    DateDuration age = AgeCalculator.age(params.birthDate);
    return Future.value(age.years>=legalAge);
  }

}

class AgeValidationParams extends Equatable{
  final DateTime birthDate;

  const AgeValidationParams(this.birthDate);
  
  @override
  List<Object?> get props => [birthDate];


}