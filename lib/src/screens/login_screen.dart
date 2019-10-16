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
        Transform.translate(
          offset: Offset(0, -20),
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 260, bottom: 20),
                borderOnForeground: true,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: "Usuario:"),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Contraseña:"),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(accentColor: Colors.white),
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
                                    height: 15,
                                    width: 15,
                                    margin: const EdgeInsets.only(left: 24),
                                    child: CircularProgressIndicator())
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('No estás registrado?'),
                          FlatButton(
                              textColor: Theme.of(context).primaryColor,
                              child: Text('Resgistrese'),
                              onPressed: () => _goToRegister(context))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
  }

  _goToRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }
}
