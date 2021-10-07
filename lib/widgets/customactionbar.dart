import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_delivery/widgets/styles.dart';

//custom action bar
class CustomActionBar extends StatelessWidget {
  //use in multiples pages
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;
  final CollectionReference _usersReference = FirebaseFirestore.instance.collection("Users");

  //currenct user
  User? _user = FirebaseAuth.instance.currentUser;

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
          begin: const Alignment(0, 0),
          end: const Alignment(0, 1),
        ) : null,
      ),
      padding: const EdgeInsets.only(
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
            GestureDetector(
              //return page
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 63.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: const Center(
                  child: Image(
                    image: AssetImage("assets/back_arrow.png"),
                    width: 18.0,
                    height: 18.0,
                    color: Colors.white,
                  ),
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
                const Image(
                  image: AssetImage("assets/cart.png"),
                  width: 18.0,
                  height: 18.0,
                  color: Colors.white,
                ),
                StreamBuilder(
                  //add to user cart
                  stream: _usersReference.doc(_user!.uid).collection("Cart").snapshots(),
                  builder: (context, snapshot) {

                    int _totalItems = 0;

                    //count all products in user's cart
                    if(snapshot.connectionState == ConnectionState.active) {
                      List _documents = (snapshot.data as dynamic).docs;
                      _totalItems = _documents.length;
                    }

                    return Text(
                      _totalItems.toString(),
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    );
                  }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
