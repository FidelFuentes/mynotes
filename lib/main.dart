


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';



void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      //named routes
      routes:{
        '/login/':(context)=> const LoginView(),
        '/register/': (context) => const ResgisterView(),
      },
    ));
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            
            case ConnectionState.done:
           //final user = FirebaseAuth.instance.currentUser;
            // if the user email exist take it, if not use false ==>
           //final emailVerified = user?.emailVerified ?? false;
          // if(emailVerified){
          // return const Text('Done'); 
           //} else {
            // push on the screeen this content
           // return const VerifyEmailView();
            //pushing a view on the screen
           // Navigator.of(context).push(MaterialPageRoute(
            //  builder:(context)=>VerifyEmailView(),));
          // }
              return const LoginView();
              //ask the user to login again, for the app know that you verify your email
        default:
        return const CircularProgressIndicator();
          }   
        },   
      );
  }
}

