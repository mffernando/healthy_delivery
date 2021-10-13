import 'package:flutter/material.dart';
import 'package:healthy_delivery/screens/productpage.dart';
import 'package:healthy_delivery/widgets/styles.dart';

class ProductCard extends StatelessWidget {
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  final String productId;

  ProductCard({
    required this.onPressed,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productId,
});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //go to product page
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductPage(productId: productId),
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
                  imageUrl,
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
                      title,
                      style: Styles.regularBoldText),
                  Text(
                      price,
                      style: Styles.regularText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
