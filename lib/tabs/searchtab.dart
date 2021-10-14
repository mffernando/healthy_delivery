import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_delivery/screens/productpage.dart';
import 'package:healthy_delivery/services/firebaseservices.dart';
import 'package:healthy_delivery/widgets/custominputfield.dart';
import 'package:healthy_delivery/widgets/productcard.dart';
import 'package:healthy_delivery/widgets/styles.dart';

class SearchTab extends StatefulWidget {

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if(_searchString.isEmpty)
            Center(
              child: Container(
                  child: const Text(
                      "Search Products",
                      style: Styles.regularBoldText),
              ),
            )
          else
          FutureBuilder<QuerySnapshot>(
            //search products by name
            future: _firebaseServices.productsReference
                .orderBy('name')
                .startAt([_searchString])
                .endAt(["$_searchString\uf8ff"])
                .get(),
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
                      top: 128.0,
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
          Padding(
            padding: const EdgeInsets.only(
              top: 45.0,
            ),
            child: CustomInputField(
              onChanged: (value) {
                //text field
                if(value.isNotEmpty) {
                  setState(() {
                    _searchString = value.toLowerCase();
                  });
                }
              },
              hintText: "Search Products",
              obscureText: false,
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }
}
