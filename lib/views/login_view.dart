

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


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
                        final UserCredential= await FirebaseAuth.instance
                 .signInWithEmailAndPassword(
                    email: email,
                    password: password,
                     );
                     print(UserCredential);
                     } on FirebaseAuthException catch (e){
                      // the way to catch a single error
                     // print(e.code);
                     if (e.code == 'invalid-credential'){
                      print('Incorrect user or password');
                     } else {
                      print('something happend');
                      print(e.code);
                     }
                     } 
                },
                child: const Text('Log in'),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/register/',
                     (route) => false);
                  }, 
                  child: const Text ('Not registered yet? Register here!')
                  )
            ],
          ),
    );
  }
}

