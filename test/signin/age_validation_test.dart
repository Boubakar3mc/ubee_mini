import 'package:flutter_test/flutter_test.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/age_validation.dart';

void main() {
  testWidgets('Devrait retourner false, trop jeune',
      (WidgetTester tester) async {
    AgeValidation ageValidation = AgeValidation();

    DateTime birthDate = DateTime(2010, 7, 7);
    bool isLegalAge = await ageValidation.call(AgeValidationParams(birthDate));
    expect(isLegalAge, false);
  });

  testWidgets('Devrait retourner false,18 ans demain',
      (WidgetTester tester) async {
    AgeValidation ageValidation = AgeValidation();

    DateTime birthDate = DateTime(
        DateTime.now().year - 18, DateTime.now().month, DateTime.now().day + 1);
    bool isLegalAge = await ageValidation.call(AgeValidationParams(birthDate));
    expect(isLegalAge, false);
  });

  testWidgets('Devrait retourner false, pas encore né',
      (WidgetTester tester) async {
    AgeValidation ageValidation = AgeValidation();

    DateTime birthDate = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    bool isLegalAge = await ageValidation.call(AgeValidationParams(birthDate));
    expect(isLegalAge, false);
  });

  testWidgets('Devrait retourner true, 18 ans aujourd\'hui',
      (WidgetTester tester) async {
    AgeValidation ageValidation = AgeValidation();

    DateTime birthDate = DateTime(
        DateTime.now().year-18, DateTime.now().month, DateTime.now().day);
    bool isLegalAge = await ageValidation.call(AgeValidationParams(birthDate));
    expect(isLegalAge, true);
  });
}
