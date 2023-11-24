import 'package:flutter_test/flutter_test.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/email_validation.dart';

void main() {
  testWidgets('Devrait retourner false', (WidgetTester tester) async {
    EmailValidation emailValidation = EmailValidation();

    String email = "gerald";
    bool emailPass = await emailValidation.call(EmailValidationParams(email));
    expect(emailPass, false);

    email = "garald.com";
    emailPass = await emailValidation.call(EmailValidationParams(email));
    expect(emailPass, false);

    email = "garald@hotmail";
    emailPass = await emailValidation.call(EmailValidationParams(email));
    expect(emailPass, false);
  });

  testWidgets('Devrait retourner true', (WidgetTester tester) async {
    EmailValidation emailValidation = EmailValidation();

    String email = "gerald@hotmail.com";
    bool emailPass = await emailValidation.call(EmailValidationParams(email));
    expect(emailPass, true);

  });
}
