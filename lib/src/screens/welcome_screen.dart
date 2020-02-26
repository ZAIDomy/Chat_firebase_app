import 'package:cable_chat_app/src/widgets/app_button.dart';
import 'package:cable_chat_app/src/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {

  static const String routeName = '';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppIcon(),
            SizedBox(height: 30.0,),
            AppButton(
              color: Colors.blueGrey[200],
              value: "Log in",
              onPressed: (){Navigator.pushNamed(context, "/login");}
            ),
            AppButton(
              color: Colors.blueGrey[600],
              value: "Registrer",
              onPressed: (){Navigator.pushNamed(context, "/registration");}
            )

          ],
        ),
      )
    );
  }
}