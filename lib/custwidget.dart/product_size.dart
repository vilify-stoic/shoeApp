import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List productSize;
  final Function(String) onSelected;
  ProductSize({this.productSize, this.onSelected});
  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          for (int i = 0; i < widget.productSize.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected("$widget.productSize[i]");
                setState(() {
                  selected = i;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selected == i
                      ? Theme.of(context).accentColor
                      : Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                margin: EdgeInsets.all(8.0),
                width: 42.0,
                height: 42.0,
                alignment: Alignment.center,
                child: Text(
                  "${widget.productSize[i]}",
                  style: TextStyle(
                    color: selected == i ? Colors.white : Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
