import 'package:flutter/material.dart';

// e-mail form
class EmailForm extends StatefulWidget {
  //const EmailForm({Key? key}) : super(key: key);

  const EmailForm({required this.callback});
  final void Function(String email) callback;

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
