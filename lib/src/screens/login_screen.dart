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
          padding: EdgeInsets.symmetric(vertical: 60),
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.cyan[300], Colors.cyan[800]]),
          ),
          child: Image.asset(
            "assets/logo.png",
            color: Colors.white,
            height: 200,
          ),
        ),
        Center(
          child: Card(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 260),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "Usuario:"),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
