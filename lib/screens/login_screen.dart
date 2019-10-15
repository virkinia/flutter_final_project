import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.cyan[300], Colors.cyan[800]]),
          ),
        ),
      ],
    ));
  }
}
