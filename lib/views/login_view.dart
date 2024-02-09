

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

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
        backgroundColor: const Color.fromARGB(255, 98, 185, 200),
        title: const Text('Login'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            
            case ConnectionState.done:
              return Column(
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
          ],
        );
        default:
        return const Text('Loading...');
          }   
        },   
      ),
    );
  }
}

