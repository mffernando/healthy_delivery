import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  //const CustomButton({Key? key}) : super(key: key);

  final String title;
  final void Function()? onPressed;
  final bool outlineButton;

  CustomButton({
    required this.title,
    required this.onPressed,
    required this.outlineButton
});

  @override
  Widget build(BuildContext context) {

    bool _outlineButton = outlineButton;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineButton ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: _outlineButton ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
