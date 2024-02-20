
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/new_note_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';
//import 'dart:developer' as devtools show log;


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
        loginRoute:(context)=> const LoginView(),
        registerRoute:(context) => const ResgisterView(),
        notesRoute:(context) => const NotesView(),
        verifyEmailRoute:(context) => const VerifyEmailView(),
        newNOteRoute:(context) => const NewNoteView(),
      },
    ));
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            
            case ConnectionState.done:
           final user = AuthService.firebase().currentUser;
           if(user != null){
            if(user.isEmailVerified){
              return const NotesView();
            } else{
              return const VerifyEmailView();
            }
           } else {
            return const LoginView();
           }
          
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
              
              //ask the user to login again, for the app know that you verify your email
        default:
        return const CircularProgressIndicator();
          }   
        },   
      );
  }
}


