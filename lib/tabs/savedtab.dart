import 'package:flutter/material.dart';
import 'package:healthy_delivery/widgets/customactionbar.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("SavedTab"),
          ),
          CustomActionBar(
            title: "Saved Products",
            hasBackArrow: false, //if page has back arrow
            hasTitle: true, // if page has title
            hasBackground: true, //if page has background
          ), //custom action bar
        ],
      ),
    );
  }
}
