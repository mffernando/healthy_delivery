import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomBottomTabs extends StatefulWidget {

  //selected tab
  final int selectedTab;
  //pressed bottom button function
  final Function(int) pressedTab;
  CustomBottomTabs({required this.selectedTab, required this.pressedTab});

  @override
  State<CustomBottomTabs> createState() => _CustomBottomTabsState();
}

class _CustomBottomTabsState extends State<CustomBottomTabs> {
  //selected tab
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    //selected tab / page
    _selectedTab = widget.selectedTab;

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 12.0
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          //top border
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 1.0,
            //blurRadius: 30.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomBottomTabButton(
              imagePath: "assets/tab_home.png", //icon
              selectedButton: _selectedTab == 0 ? true : false, //selected tab
              onPressed: () {
                widget.pressedTab(0); //pressed tab
              },
          ), //home button
          CustomBottomTabButton(
              imagePath: "assets/tab_search.png", //icon
              selectedButton: _selectedTab == 1 ? true : false, //selected tab
              onPressed: () {
                widget.pressedTab(1); //pressed tab
              },
          ), //search button
          CustomBottomTabButton(
              imagePath: "assets/tab_saved.png", //icon
              selectedButton: _selectedTab == 2 ? true : false, //selected tab
              onPressed: () {
                widget.pressedTab(2); //pressed tab
              },
          ), //saved button
          CustomBottomTabButton(
              imagePath: "assets/tab_logout.png", //icon
            selectedButton: _selectedTab == 3 ? true : false, //selected tab
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ) // logout button
        ],
      ),
    );
  }
}

//custom buttons
class CustomBottomTabButton extends StatelessWidget {

  //image path variable
  final String imagePath;
  //selected bottom button
  final bool selectedButton;
  //pressed button function
  final Function()? onPressed;

  CustomBottomTabButton({required this.imagePath, required this.selectedButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    bool _selectedButton = selectedButton;

    return GestureDetector(
      onTap: onPressed, //pressed button
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 4.0
        ),
        decoration: BoxDecoration(
          //change clicked button color
          border: Border(
            bottom: BorderSide(
              color: _selectedButton ? Colors.red : Colors.transparent, //boxDecoration selected color
              width: 2.0,
            )
          )
        ),
        child: Image(
          image: AssetImage(imagePath),
          width: 24.0,
          height: 24.0,
          color: _selectedButton ? Colors.red : Colors.black, //icon selected color
        ),
      ),
    );
  }
}

