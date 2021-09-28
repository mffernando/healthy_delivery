import 'package:flutter/material.dart';
import 'package:healthy_delivery/widgets/styles.dart';

class CustomInputField extends StatelessWidget {
  // const CustomInputField({Key? key}) : super(key: key);

  final String hintText;
  final Function(String)? onChanged;
  final bool obscureText;

  CustomInputField({
    required this.hintText,
    required this.onChanged,
    required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 20.0,
          )
        ),
        style: Styles.regularBoldText,
      ),
    );
  }
}
