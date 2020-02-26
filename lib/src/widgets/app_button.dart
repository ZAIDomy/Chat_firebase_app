import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final Color color;
  final String value;
  final VoidCallback onPressed;

  const AppButton({this.color,this.value,this.onPressed});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 4.0,
        child: SizedBox(
          height: 40.0,
          child: FlatButton(
          child: Text(value),
          onPressed: onPressed,
        ),
      )
      ),
    );


  }
}