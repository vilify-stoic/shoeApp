import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusnode;
  final TextInputAction textInputAction;
  final bool isPasswordfield;

  CustomInput({
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.focusnode,
    this.textInputAction,
    this.isPasswordfield,
  });
  @override
  Widget build(BuildContext context) {
    bool _issecure = isPasswordfield ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        focusNode: focusnode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        obscureText: _issecure,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint ?? "Hint Text",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 18.0,
            )),
      ),
    );
  }
}
