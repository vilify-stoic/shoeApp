import 'package:ecommerce/constant.dart';
import 'package:flutter/material.dart';

class CustomButtonAction extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlinebtn;
  final bool isLoading;

  CustomButtonAction(
      {this.text, this.onPressed, this.outlinebtn, this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _outline = outlinebtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
        onTap: onPressed,
        child: Container(
            height: 55.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: _outline ? Colors.transparent : Colors.black,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(12.0)),
            margin: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Visibility(
              visible: _isLoading ? false : true,
              child: Stack(children: [
                Center(
                  child: Text(
                    text ?? "Text",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: _outline ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Visibility(
                  visible: _isLoading,
                  child: Center(
                    child: SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ]),
            )));
  }
}
