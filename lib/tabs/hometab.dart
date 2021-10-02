import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_delivery/widgets/customactionbar.dart';

class HomeTab extends StatelessWidget {

  //collections in firestore (Products Reference)
  final CollectionReference _productsReference = FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            //get products
            future: _productsReference.get(),
            builder: (context, snapshot) {
              //error stage
              if(snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              //collection data ready to display
              if(snapshot.connectionState == ConnectionState.done) {
                //display the data inside a list view
                return ListView(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 24.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          //color: Colors.grey,
                          border: Border.all(),
                        ),
                        height: 200.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0
                        ),
                        //product name
                        //child: Text("Product Name: ${(document.data()as dynamic)['name']}"),
                        //show first image of the products
                        child: Image.network(
                          "${(document.data()as dynamic)['images'][0]}",
                          fit: BoxFit.contain,
                        ),
                      );
                    }).toList()
                );
              }
              //loading stage
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
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
