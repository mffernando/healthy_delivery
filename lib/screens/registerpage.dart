import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_delivery/widgets/custombutton.dart';
import 'package:healthy_delivery/widgets/custominputfield.dart';
import 'package:healthy_delivery/widgets/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //field values
  String _email = "";
  String _password = "";

  //default loading state
  bool _registerLoading = false;

  //create new user
  Future<String?> _createUser() async {
    try {
      //Anonymously
      //UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      //print("E-mail: $_email");
      //print("Password: $_password");
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      print("User: $userCredential");
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message; //default error message
    } catch(e) {
      return e.toString();
    }
  }

  void _submitForm(BuildContext context) async {

    //start loading
    setState(() {
      _registerLoading = true;
    });

    //run create user account method
    String? _createUserFeedback = await _createUser();

    if(_createUserFeedback != null) {
      _alertDialog(context, _createUserFeedback);

      //stop loading
      setState(() {
        _registerLoading = false;
      });

    } else {
      //navigate to home page
     Navigator.pop(context);
    }
  }

  // alert dialog to display some errors.
  Future<void> _alertDialog(BuildContext context, String error) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close Dialog"),
              )
            ],
          );
        }
    );
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
                "Create a New Account!",
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
                  textInputAction: TextInputAction.next,
                ),
                CustomInputField(
                  onChanged: (value) {
                    _password = value;
                  },
                  hintText: "Password",
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                ),
                CustomButton(
                  title: "Create a New Account",
                  onPressed: () {
                    _submitForm(context);
                  },
                  outlineButton: false,
                  isLoading: _registerLoading,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16.0
              ),
              child: CustomButton(
                title: "Back to Login",
                onPressed: () {
                  Navigator.pop(context);
                },
                outlineButton: true,
                isLoading: _registerLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
