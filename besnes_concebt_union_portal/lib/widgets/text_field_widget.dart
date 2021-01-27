import 'package:flutter/material.dart';

import '../AppTheme.dart';
import '../SizeConfig.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final String errorText;

  TextFieldWidget({
    this.icon,
    @required this.hintText,
    @required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      textAlign: TextAlign.start,
      keyboardType: keyboardType,
      cursorColor: AppTheme.buttonsColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme.itemColor,
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          color: AppTheme.buttonsColor,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10.0,
        ),
        hintStyle: TextStyle(
          color: AppTheme.subTitleTextColor,
          fontSize: 1.5 * SizeConfig.textMultiplier,
          fontFamily: "Cairo",
        ),
        border: outlineInputBorder(Colors.grey[200], 2.0, 16.0),
        enabledBorder: outlineInputBorder(Colors.grey[200], 2.0, 16.0),
        focusedBorder: outlineInputBorder(Colors.grey[200], 2.0, 16.0),
        focusedErrorBorder: outlineInputBorder(Colors.grey[200], 2.0, 16.0),
        errorBorder: outlineInputBorder(Colors.grey[200], 2.0, 16.0),
        errorText: errorText,
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder(
    Color color, double width, double radius) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: width),
    borderRadius: BorderRadius.all(
      Radius.circular(radius),
    ),
  );
}
