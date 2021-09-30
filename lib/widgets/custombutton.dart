import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  //const CustomButton({Key? key}) : super(key: key);

  final String title;
  final void Function()? onPressed;
  final bool outlineButton;
  final bool isLoading;

  CustomButton({
    required this.title,
    required this.onPressed,
    required this.outlineButton,
    required this.isLoading
});

  @override
  Widget build(BuildContext context) {

    bool _outlineButton = outlineButton;
    bool _isLoading = isLoading;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65.0,
        //alignment: Alignment.center,
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
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _outlineButton ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            //loading
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator()
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
