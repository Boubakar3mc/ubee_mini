import 'package:flutter_test/flutter_test.dart';
import 'package:ubee_mini/features/authentication/domain/use_cases/password_match_check.dart';

void main(){
  testWidgets('Devrait retourner false', (WidgetTester tester) async{
    String password1 = "1942149";
    String password2 = "1922141";

    PasswordMatchCheck passwordMatchCheck = PasswordMatchCheck();
    bool match = await passwordMatchCheck.call(PasswordMathcCheckParams(password1, password2));

    expect(match,false);
  });

  testWidgets('Devrait retourner true', (WidgetTester tester) async{
    String password1 = "1942149";
    String password2 = "1942149";

    PasswordMatchCheck passwordMatchCheck = PasswordMatchCheck();
    bool match = await passwordMatchCheck.call(PasswordMathcCheckParams(password1, password2));

    expect(match,true);
  });
}