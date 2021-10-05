import 'package:flutter/material.dart';
import 'package:healthy_delivery/widgets/styles.dart';

//custom action bar
class CustomActionBar extends StatelessWidget {
  //use in multiples pages
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;

  CustomActionBar({
    required this.title,
    required this.hasBackArrow,
    required this.hasTitle,
    required this.hasBackground
  });

  @override
  Widget build(BuildContext context) {

    bool _hasBackArrow = hasBackArrow;
    bool _hasTitle = hasTitle;
    bool _hasBackground = hasBackground;

    return Container(
      decoration: BoxDecoration(
        gradient: _hasBackground ? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0),
          ],
          begin: Alignment(0, 0),
          end: Alignment(0, 1),
        ) : null,
      ),
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0
      ),
      child: Row(
        //action bar and cart
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //if page has back arrow
          if(_hasBackArrow)
            Container(
              width: 63.0,
              height: 42.0,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)
              ),
              child: Center(
                child: Image(
                  image: AssetImage("assets/back_arrow.png"),
                  width: 18.0,
                  height: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          //if page has title
          if(_hasTitle)
            Text(
              title, //page title
              style: Styles.boldHeading
            ),
          Container(
            width: 63.0,
            height: 42.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0)
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(
                  image: AssetImage("assets/cart.png"),
                  width: 18.0,
                  height: 18.0,
                  color: Colors.white,
                ),
                Text(
                  "0",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
