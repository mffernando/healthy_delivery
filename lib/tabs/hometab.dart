import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_delivery/screens/productpage.dart';
import 'package:healthy_delivery/widgets/customactionbar.dart';
import 'package:healthy_delivery/widgets/styles.dart';

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
                    return GestureDetector(
                      onTap: () {
                        //go to product page
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ProductPage(productId: document.id),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          //color: Colors.grey,
                          border: Border.all(),
                        ),
                        height: 100.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0
                        ),
                        //show first image of the products
                        child: Stack(
                          children: [
                            Container(
                              //image size
                              height: 100.0,
                              alignment: Alignment.centerRight,
                              //padding: const EdgeInsets.all(20.0),
                              child: ClipRRect(
                                child: Image.network(
                                  //first image
                                  "${(document.data()as dynamic)['images'][0]}",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //product name
                                children: [
                                  Text(
                                      "${(document.data()as dynamic)['name'].toUpperCase()}",
                                      style: Styles.regularBoldText),
                                  Text(
                                      "R\$: ${(document.data()as dynamic)['price'][0]}",
                                       style: Styles.regularText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
