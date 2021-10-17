import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_delivery/screens/productpage.dart';
import 'package:healthy_delivery/services/firebaseservices.dart';
import 'package:healthy_delivery/widgets/customactionbar.dart';


class SavedTab extends StatelessWidget {

  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            //get products by user
            future: _firebaseServices.usersReference.doc(_firebaseServices.getUserId()).collection("Saved").get(),
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
                        child: FutureBuilder(
                          future: _firebaseServices.productsReference.doc(document.id).get(),
                          builder: (context, productSnapshot) {
                            //if has error
                            if(productSnapshot.hasError) {
                              return Container(
                                child: Center(
                                  child: Text("${productSnapshot.error}"),
                                ),
                              );
                            }
                            //if is done
                            if(productSnapshot.connectionState == ConnectionState.done) {
                              Map _productMap = (productSnapshot.data as dynamic).data();

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 24.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          "${_productMap['images'][0]}",
                                          //fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 16.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_productMap['name'].toUpperCase()}",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4.0,
                                            ),
                                            child: Text(
                                              "Amount - ${(document.data()as dynamic)['amount']}",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "R\$ - ${_productMap['price']}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            //else return loading
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
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
