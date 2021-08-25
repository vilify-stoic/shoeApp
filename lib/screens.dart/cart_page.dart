import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/custwidget.dart/custom_action_bar.dart';
import 'package:ecommerce/screens.dart/product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('products');

  User _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _usersRef.doc(_user.uid).collection("Cart").get(),
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
                    padding: EdgeInsets.only(top: 108.0, bottom: 12.0),
                    children: snapshot.data.docs.map((document) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                          productId: document.id,
                                        )));
                          },
                          child: FutureBuilder(
                            future: _productRef.doc(document.id).get(),
                            builder: (context, productshot) {
                              if (productshot.hasError) {
                                return Container(
                                  child: Center(
                                    child: Text("${productshot.error}"),
                                  ),
                                );
                              }

                              if (productshot.connectionState ==
                                  ConnectionState.done) {
                                Map _productnap = productshot.data.data();
                                return Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, top: 15.0),
                                        child: Center(
                                          child: Container(
                                            height: 90.0,
                                            width: 90.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                "${_productnap['images'][0]}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_productnap['name']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.0,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "\$ ${_productnap['Price']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.0,
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            ),
                                            Text(
                                              //document
                                              "Size - ${document.data()['Size']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        )),
                                  ],
                                );
                              }
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ));
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
            title: "Cart",
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
