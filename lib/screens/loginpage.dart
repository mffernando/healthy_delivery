import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_delivery/screens/registerpage.dart';
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

  //default loading state
  bool _loginLoading = false;

class _LoginPageState extends State<LoginPage> {

  Future<String?> _loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
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
      _loginLoading = true;
    });

    //run create user account method
    String? _loginFeedback = await _loginUser();

    if(_loginFeedback != null) {
      _alertDialog(context, _loginFeedback);

      //stop loading
      setState(() {
        _loginLoading = false;
      });

    }
    //stop loading
    setState(() {
      _loginLoading = false;
    });
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
                  title: "Login",
                  onPressed: () {
                    _submitForm(context);
                  },
                  outlineButton: false,
                  isLoading: _loginLoading,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16.0
              ),
              child: CustomButton(
                title: "Create New Account",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage()
                    )
                  );
                },
                outlineButton: true,
                isLoading: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
