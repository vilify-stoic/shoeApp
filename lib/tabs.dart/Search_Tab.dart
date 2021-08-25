import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/custwidget.dart/custon_inp.dart';
import 'package:ecommerce/custwidget.dart/prooduct__cart.dart';
import 'package:ecommerce/screens.dart/product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('products');

  User _user = FirebaseAuth.instance.currentUser;

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: Stack(
          children: [
            if (_searchString.isEmpty)
              Center(
                  child: Text(
                "Serach Results",
                style: Constants.boldHeading,
              ))
            else
              FutureBuilder<QuerySnapshot>(
                  future: _productRef.orderBy("name").startAt(
                      [_searchString]).endAt(['$_searchString\uf8ff']).get(),
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
            CustomInput(
              hint: "Search Here...",
              onSubmitted: (value) {
                if (value != null) {
                  setState(() {
                    _searchString = value.toUpperCase();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
