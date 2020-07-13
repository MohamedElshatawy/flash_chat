import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  final String hintText;
  final IconButton suffixIcon;
  final Icon icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function onChanged;
  final String error;
  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final TextEditingController controller;
  final String Function(String value) validator;
  RoundTextField({
    this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.onChanged,
    this.icon,
    this.error,
    this.padding,
    this.contentPadding,
    this.controller, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        autocorrect: true,
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          errorText: error,
          contentPadding: contentPadding,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        ),
      ),
    );
  }
}
