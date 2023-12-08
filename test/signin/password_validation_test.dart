import 'package:flutter_test/flutter_test.dart';
import 'package:ubee_mini/features/signin/domain/use_cases/password_validation.dart';

void main(){
  testWidgets('Devrait retourner false', (WidgetTester tester) async{
    PasswordValidation passwordValidation = PasswordValidation();
    
    String password = "123456789";
    bool passwordPass = await passwordValidation.call(PasswordValidationParams(password));
    expect(passwordPass,false);

    password = "********";
    passwordPass = await passwordValidation.call(PasswordValidationParams(password));
    expect(passwordPass,false);
    
    password = "1Aa?"; //Bon caractères mais pas assez long
    passwordPass =  await passwordValidation.call(PasswordValidationParams(password));
    expect(passwordPass,false);

    password = "1ea&3904"; //Bon caractères mais manque lettre majuscule
    passwordPass =  await passwordValidation.call(PasswordValidationParams(password));
    expect(passwordPass,false);
    
  });

  testWidgets('Devrait retourner true', (WidgetTester tester) async{
    PasswordValidation passwordValidation = PasswordValidation();
    
    String password = "Fav%5r32";
    bool passwordPass =  await passwordValidation.call(PasswordValidationParams(password));
    expect(passwordPass,true);

    password = "Charlie18#";
    passwordPass =  await passwordValidation.call(PasswordValidationParams(password));
    expect(passwordPass,true);

  });
}