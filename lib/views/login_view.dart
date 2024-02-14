
import 'package:flutter/material.dart';
//import 'dart:developer' as devtools show log;
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

// f2 for rename a wid
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

late final TextEditingController _email;
late final TextEditingController _password;

@override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              TextButton(
                onPressed: () async {
      
                  final email = _email.text;
                  final password = _password.text;
                  
                    try{
                      
                    await AuthService.firebase().logIn(
                       email: email,
                       password: password,);

                     final user = AuthService.firebase().currentUser;
                     if(user?.isEmailVerified ?? false){
                        // email verified
                      Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute, 
                      (route) => false);
                     } else {
                        // user is not verified
                        Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute, 
                      (route) => false);

                     }
                     
                     } on UserNotFoundAuthException{
                       await showErrorDialog(
                        context,
                         "Invalid credentials");
                     } on WrongPasswordAuthException{
                        await showErrorDialog(
                          context,
                           'Wrong password');
                     } on GenericAuthException{
                       await showErrorDialog(
                        context,
                         'Authentication error',
                         );
                     }
                },
                child: const Text('Log in'),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil( //push an screen on top the other, named route, remove the one besides.
                      registerRoute,
                     (route) => false); // remove everthing.
                  }, 
                  child: const Text ('Not registered yet? Register here!')
                  )
            ],
          ),
    );
  }
}
