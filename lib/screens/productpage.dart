import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_delivery/widgets/customactionbar.dart';
import 'package:healthy_delivery/widgets/imageswipe.dart';
import 'package:healthy_delivery/widgets/styles.dart';

class ProductPage extends StatefulWidget {

  //clicked product id
  final String productId;

  //constructor
  ProductPage({required this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  //collections in firestore (Products Reference)
  final CollectionReference _productsReference = FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            //get product by id
            future: _productsReference.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              //if has data
              if(snapshot.connectionState == ConnectionState.done) {
                //firebase document data map
                Map<String, dynamic> documentData = (snapshot.data as dynamic).data();

                //list of images
                List imageList = documentData['images'];

                return ListView(
                  padding: const EdgeInsets.only(
                    top: 100,
                  ),
                  children: [
                    //product image
                    ImageSwipe(imageList: imageList),
                    //product name
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                          "${documentData['name'].toUpperCase()}",
                          style: Styles.boldHeading,
                      ),
                    ),
                    //product price
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                          "R\$ ${documentData['price'][0]}",
                          style: Styles.regularText,
                      ),
                    ),
                    //product description
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                          "Description: ${documentData['description']}",
                          style: Styles.regularText,
                      ),
                    ),
                    //product size
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                          "Amount: ${documentData['amount']}",
                          style: Styles.regularText,
                      ),
                    ),
                  ],
                );

              }

              //loading state
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
            title: "",
            hasBackground: false,
          ),
        ],
      ),
    );
  }
}