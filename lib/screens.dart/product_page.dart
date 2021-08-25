import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/custwidget.dart/custom_action_bar.dart';
import 'package:ecommerce/custwidget.dart/image_swipe.dart';
import 'package:ecommerce/custwidget.dart/product_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('Users');

  User _user = FirebaseAuth.instance.currentUser;

  String _selectedProductSize = "0";

  Future _addtoCart() {
    return _usersRef
        .doc(_user.uid)
        .collection("Cart")
        .doc(widget.productId)
        .set({"Size": _selectedProductSize});
  }

  final SnackBar _snackbar = SnackBar(content: Text("Product Added To Cart"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FutureBuilder(
            future: _productRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();
                List imageList = documentData["images"];
                List productSize = documentData['Size'];

                _selectedProductSize = productSize[0];
                return ListView(
                  children: [
                    ImageSwipe(imageList: imageList),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24.0, top: 24.0, bottom: 4.0),
                      child: Text(
                        '${documentData['name']}' ?? "Product Name",
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 4.0),
                      child: Text(
                        '\$ ${documentData['Price']}' ?? "Price",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 4.0),
                      child: Text('${documentData['Desc']}' ?? "Description",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 4.0),
                      child: Text(
                        "Select Size",
                        style: Constants.boldHeading,
                      ),
                    ),
                    ProductSize(
                      productSize: productSize,
                      onSelected: (size) {
                        _selectedProductSize = size;
                      },
                    ),
                    SizedBox(
                      height: 45.0,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 24, bottom: 16.0),
                          child: Container(
                            height: 65.0,
                            width: 65.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Image(
                              image: AssetImage("assets/images/tab_saved.png"),
                              width: 20.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() async {
                              await _addtoCart();
                              Scaffold.of(context).showSnackBar(_snackbar);
                            });
                          },
                          child: Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 16, right: 16.0, bottom: 16.0),
                              height: 65.0,
                              width: 250.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Add To Cart",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
              return Scaffold(
                body: Center(
                  child: Text("Error ${snapshot.error}",
                      style: Constants.regularHeading),
                ),
              );
            }),
        CustomActionBar(
          hasBackArrow: true,
          hasTitle: false,
        )
      ]),
    );
  }
}
