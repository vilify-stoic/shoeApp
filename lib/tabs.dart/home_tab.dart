import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/custwidget.dart/custom_action_bar.dart';
import 'package:ecommerce/custwidget.dart/prooduct__cart.dart';
import 'package:ecommerce/screens.dart/product_page.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  CollectionReference _productRef =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _productRef.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error ${snapshot.error}",
                          style: Constants.regularHeading),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    padding: EdgeInsets.only(top: 102.0),
                    children: snapshot.data.docs.map((document) {
                      return ProductCart(
                        title: document.data()['name'],
                        imageUrl: document.data()['images'][0],
                        price: "${document.data()["Price"]}",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                        productId: document.id,
                                      )));
                        },
                      );
                    }).toList(),
                  );
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            hasBackArrow: false,
            title: "Home",
            // hasTitle: false,
          ),
        ],
      ),
    );
  }
}
