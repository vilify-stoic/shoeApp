import 'package:ecommerce/custwidget.dart/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          CustomActionBar(
            hasBackArrow: false,
            title: "Saved",
            // hasTitle: false,
          ),
        ],
      ),
    );
  }
}
