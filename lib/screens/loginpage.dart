import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<void> _createUser() async {
    try {
      //Anonymously
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("User: $userCredential");
    } on FirebaseAuthException catch(e) {
      print("Error: $e");
    } catch(e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoginPage"),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: _createUser,
          child: Text("Create New Account"),
        ),
      ),
    );
  }
}
