import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {

  final String inputText;
  final ValueChanged<String> onSaved;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldValidator<String> validator ;
  final bool autovalidate;

  const AppTextField({this.inputText, this.onSaved, this.obscureText, this.controller, this.focusNode, this.validator, this.autovalidate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidate: autovalidate,
      validator: validator,
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        hintText: inputText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(color: Colors.blueGrey[200])
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: BorderSide(color: Colors.blueGrey[700])
        )
      ),
      onSaved: onSaved,
      textAlign: TextAlign.center,
      obscureText: obscureText == null ? false : obscureText,
    );
  }
}