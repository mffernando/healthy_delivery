import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

  String _email = "";
  String _password = "";

class _LoginPageState extends State<LoginPage> {

  Future<void> _createUser() async {
    try {
      //Anonymously
      //UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      //print("E-mail: $_email");
      //print("Password: $_password");
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      print("User: $userCredential");
    } on FirebaseAuthException catch(e) {
      print("Error: $e");
    } catch(e) {
      print("Error: $e");
    }
  }

  Future<void> _loginUser() async {
    try {
      //Anonymously
      //UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      //print("E-mail: $_email");
      //print("Password: $_password");
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
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
        title: const Text("LoginPage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                _email = value;
              },
              decoration: const InputDecoration(
                hintText: "E-mail Field"
              ),
            ),
            TextField(
              onChanged: (value) {
                _password = value;
              },
              decoration: const InputDecoration(
                  hintText: "Password Field"
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: _loginUser,
                  child: const Text("Login"),
                ),
                MaterialButton(
                  onPressed: _createUser,
                  child: const Text("Create New Account"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
