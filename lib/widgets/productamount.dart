import 'package:flutter/material.dart';

class ProductAmount extends StatefulWidget {
  final List amountList;
  final Function(String) onSelected;
  ProductAmount(
      {
        required this.amountList,
        required this.onSelected,
      }
      );

  @override
  _ProductAmountState createState() => _ProductAmountState();
}

class _ProductAmountState extends State<ProductAmount> {

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Row(
        children: [
          for(var i=0; i < widget.amountList.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  //selected amount index
                  widget.onSelected("${widget.amountList[i]}");
                  //selected button
                  _selected = i;
                });
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  //selected button color
                  color: _selected == i ? Colors.red : Colors.grey,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text(
                  "${widget.amountList[i]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    //selected button color
                    color: _selected == i ? Colors.white : Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
