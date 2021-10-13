import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_delivery/screens/productpage.dart';
import 'package:healthy_delivery/widgets/customactionbar.dart';
import 'package:healthy_delivery/widgets/productcard.dart';

class HomeTab extends StatelessWidget {

  //collections in firestore (Products Reference)
  final CollectionReference _productsReference = FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                padding: const EdgeInsets.only(
                  top: 108.0,
                  bottom: 24.0,
                ),
                children: snapshot.data!.docs.map((document) {
                    return ProductCard(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProductPage(productId: document.id)
                          ));
                        },
                        imageUrl: (document.data()as dynamic)['images'][0],
                        title: (document.data()as dynamic)['name'],
                        price: "R\$ ${(document.data() as dynamic)['price']}",
                        productId: document.id);
                  }).toList()
              );
            }
            //loading stage
            return const Scaffold(
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
          hasBackground: true, //if page has background
        ), //custom action bar
      ],
    );
  }
}
