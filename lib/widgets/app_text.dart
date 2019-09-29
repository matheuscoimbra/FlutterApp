import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextNode;

  AppText(
    this.label,
    this.hint, {
    this.password= false,
    this.controller,
    this.validator,
    this.textInputAction,
    this.focusNode,
    this.nextNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.text,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextNode != null) {
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      style: TextStyle(
        fontSize: 25,
      ),
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16)
      )),
      obscureText: password,
    );
  }
}
