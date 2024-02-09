

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';


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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 98, 185, 200),
        title: const Text('Register'),
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
                
                try {
                     final UserCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                   );
                   print(UserCredential);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password'){
                    print('Weak password');
                  } else if (e.code == 'email-already-in-use'){
                    print('Email is already in use');
                  } else if( e.code == 'invalid-email'){
                    print('Invalid email entered');
                  }
                }
              },
              child: const Text('Register'),
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