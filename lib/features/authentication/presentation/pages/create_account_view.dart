import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubee_mini/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ubee_mini/injection_container.dart' as injection;
import 'dart:async';

class CreateAccountView extends StatefulWidget {
  final String title;

  const CreateAccountView(this.title, {super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  TextEditingController emailTextFieldController = TextEditingController();
  TextEditingController passwordTextFieldController = TextEditingController();
  TextEditingController passwordConfirmTextFieldController =
      TextEditingController();

  Timer? _passwordValidationTypingTimer;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injection.sl<AuthenticationBloc>(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => {},
            ),
            title: Text(widget.title),
          ),
          body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: emailTextFieldController,
                              decoration: const InputDecoration(
                                labelText: "Enter your email address",
                                hintText: 'Email',
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 250,
                                child: TextField(
                                  controller: passwordTextFieldController,
                                  decoration: const InputDecoration(
                                    labelText: "Create a password",
                                    hintText: 'Password',
                                  ),
                                  //obscureText: true,
                                  onChanged: (text) {passwordValidationResetTimer(context);},
                                ),
                              ),
                              (state is AuthenticationInvalidPassword)?
                              const Text('The password must have:\n At least 8 characters \n At least 1 UpperCase character\n At least 1 LowerCase character \n At least 1 number \n At least one Special Char(!@#\$&*~%)',
                              style:TextStyle(color: Colors.red))
                              :Container(),
                              
                              (state is AuthenticationValidPassword)?Container():Container(),
                            ],
                          ),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: passwordConfirmTextFieldController,
                              decoration: const InputDecoration(
                                labelText: "Confirm password",
                                hintText: 'Confirm password',
                              ),
                              obscureText: true,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Create account'),
                          ),
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    );
            },
          )),
    );
  }

  startPasswordValidationTimer(BuildContext context){
    _passwordValidationTypingTimer = Timer(const Duration(milliseconds: 600),(){
      context.read<AuthenticationBloc>().add(PasswordTypingStopped(passwordTextFieldController.text));
    });
  }

  passwordValidationResetTimer(BuildContext context){
    _passwordValidationTypingTimer?.cancel();
    startPasswordValidationTimer(context);
  }
}
