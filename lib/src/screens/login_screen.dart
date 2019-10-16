import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

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
            borderOnForeground: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "Usuario:"),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Contraseña:"),
                    obscureText: true,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.white),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      onPressed: () => _login(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Iniciar sesión'),
                          if (_loading)
                            Container(
                                height: 20,
                                width: 20,
                                margin: const EdgeInsets.only(left: 24),
                                child: CircularProgressIndicator())
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  void _login(BuildContext context) {
    _loading = true;
  }
}
