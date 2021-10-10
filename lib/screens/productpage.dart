import 'package:flutter/material.dart';
import 'package:healthy_delivery/services/firebaseservices.dart';
import 'package:healthy_delivery/widgets/customactionbar.dart';
import 'package:healthy_delivery/widgets/imageswipe.dart';
import 'package:healthy_delivery/widgets/productamount.dart';
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
  //initialize firebase services
  FirebaseServices _firebaseServices = FirebaseServices();

  //get user id
  //User? _user = FirebaseAuth.instance.currentUser;

  //selected product amount
  String _selectedProductAmount = "0";

  //add to user's cart - function
  Future _addToCart() {
    return _firebaseServices
        .usersReference
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set(
        {
      "amount" : _selectedProductAmount
    }
    );
  }
  
  //snackbar product add
  final SnackBar _snackBar = SnackBar(
      content: Text("Product add to the cart!")
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            //get product by id
            future: _firebaseServices.productsReference
                .doc(widget.productId)
                .get(),
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
                //amount
                List amountList = documentData['amount'];

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
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                          "Amount",
                          style: Styles.regularBoldText,
                      ),
                    ),
                    ProductAmount(
                        amountList: amountList,
                      onSelected: (amount) {
                          _selectedProductAmount = amount;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey,
                            ),
                            alignment: Alignment.center,
                            child: const Image(
                              image: AssetImage(
                                "assets/tab_saved.png",
                              ),
                              height: 22.0,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              //add product to cart > Firebase > Cart
                              onTap: () async {
                                await _addToCart();
                                ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                height: 65.0,
                                margin: const EdgeInsets.only(
                                  left: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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