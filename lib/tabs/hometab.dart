import 'package:flutter/material.dart';
import 'package:healthy_delivery/widgets/customactionbar.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("HomeTab"),
          ),
          CustomActionBar(
            title: "Home",
            hasBackArrow: false, //if page has back arrow
            hasTitle: true, // if page has title
          ), //custom action bar
        ],
      ),
    );
  }
}
