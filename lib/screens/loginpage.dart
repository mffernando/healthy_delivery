import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_delivery/widgets/custombutton.dart';
import 'package:healthy_delivery/widgets/custominputfield.dart';
import 'package:healthy_delivery/widgets/styles.dart';

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
      //appBar: AppBar(
      //  title: const Text("LoginPage"),
      //),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 24.0,
              ),
              child: const Text(
                "Welcome, \n Login to Your Account!",
                textAlign: TextAlign.center,
                style: Styles.boldHeading,
              ),
            ),
            Column(
              children: [
                CustomInputField(
                  onChanged: (value) {
                    _email = value;
                  },
                  hintText: "E-mail",
                  obscureText: false,
                ),
                CustomInputField(
                  onChanged: (value) {
                    _password = value;
                  },
                  hintText: "Password",
                  obscureText: true,
                ),
                CustomButton(
                  title: "Login",
                  onPressed: _loginUser,
                  outlineButton: false,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16.0
              ),
              child: CustomButton(
                title: "Create New Account",
                onPressed: _createUser,
                outlineButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
