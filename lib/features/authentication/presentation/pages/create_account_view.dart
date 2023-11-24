import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {},
          ),
          title: Text(widget.title),
        ),
        body: Center(
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
              SizedBox(
                width: 250,
                child: TextField(
                  controller: passwordTextFieldController,
                  decoration: const InputDecoration(
                    labelText: "Create a password",
                    hintText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: passwordConfirmTextFieldController,
                  decoration: const InputDecoration(
                    labelText: "Confirm password",
                    hintText: 'Confirm password',
                  ),
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
        ));
  }
}
