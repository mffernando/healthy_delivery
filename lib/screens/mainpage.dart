import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthy_delivery/screens/homepage.dart';
import 'package:healthy_delivery/screens/loginpage.dart';

class MainPage extends StatelessWidget {
  // const MainPage({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        if(snapshot.connectionState == ConnectionState.done) {
          //StreamBuilder can check the login state
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active) {
                Object? user = snapshot.data;

                if(user == null) {
                  return LoginPage();
                } else {
                  return HomePage();
                }

              }

              return const Scaffold(
                body: Center(
                  child: Text("Auth"),
                ),
              );

            },
          );
        }

        return const Scaffold(
          body: Center(
            child: Text("Connecting to the app"),
          ),
        );

      },
    );
  }
}