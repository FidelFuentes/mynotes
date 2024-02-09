
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';

// stl ==> stateless wid
// stf ==> statefull wid
class ResgisterView extends StatefulWidget {
  const ResgisterView({super.key});

  @override
  State<ResgisterView> createState() => _ResgisterViewState();
}

class _ResgisterViewState extends State<ResgisterView> {

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
      appBar: AppBar(title: const Text('Register'),),
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
                  
                  try {
                       final UserCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                     );
                     devtools.log(UserCredential.toString());
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password'){
                      devtools.log('Weak password');
                    } else if (e.code == 'email-already-in-use'){
                      devtools.log('Email is already in use');
                    } else if( e.code == 'invalid-email'){
                      devtools.log('Invalid email entered');
                    }
                  }
                },
                child: const Text('Register'),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login/',
                   (route) => false);
                }, child: const Text('Already registered? Login here'))
            ],
          ),
    );
  }
}