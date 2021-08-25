import 'package:ecommerce/constant.dart';
import 'package:ecommerce/screens.dart/product_page.dart';
import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  final String productId;

  ProductCart(
      {this.imageUrl, this.onPressed, this.price, this.productId, this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 200.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(children: [
          Container(
            height: 250.0,
            width: 400.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                "${imageUrl}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ?? 'Product Name',
                    style: Constants.regularHeading,
                  ),
                  Text(
                    "\$ ${price}" ?? 'Price',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
