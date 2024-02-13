
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';
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
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                     );
                     final user = FirebaseAuth.instance.currentUser;
                     if(user?.emailVerified ?? false){
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
                     
                     } on FirebaseAuthException catch (e){
                      // the way to catch a single error
                     // print(e.code);
                     if (e.code == 'user-not-found'){ //I HAVE TO CHECK THE E.CODE
                      await showErrorDialog(
                        context,
                         "Invalid credentials");
                      //devtools.log('Incorrect user or password');
                     } else {
                       await showErrorDialog(
                        context,
                         "Error: ${e.code}"); //like javascript
                     }
                     } catch (e){
                      await showErrorDialog(
                        context,
                         e.toString()
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
