import 'package:cable_chat_app/src/screens/chat_screen.dart';
import 'package:cable_chat_app/src/screens/login_screen.dart';
import 'package:cable_chat_app/src/screens/registration_screen.dart';
import 'package:cable_chat_app/src/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: WelcomeScreen(),
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(
            color: Colors.black45
            )
        )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.routeName,
      routes: <String, WidgetBuilder>{
        LoginScreen.routeName : (BuildContext context) => LoginScreen(),
        WelcomeScreen.routeName : (BuildContext context) => WelcomeScreen(),
        RegistrationScreen.routeName : (BuildContext context) => RegistrationScreen(),
        ChatScreen.routeName : (BuildContext context) => ChatScreen()
      },
    )
  );
}
