import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_project/src/connections/server_controller.dart';

class LoginScreen extends StatefulWidget {
  final ServerController serverController;
  final BuildContext context;
  LoginScreen(this.serverController, this.context, {Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userName = "";
  String password = "";
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 60),
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.cyan[300], Colors.cyan[800]]),
            ),
            child: Image.asset(
              "assets/images/logo.png",
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: "Usuario:"),
                          onSaved: (value) {
                            userName = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Debe rellenar este campo";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Contraseña:"),
                          obscureText: true,
                          onSaved: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Debe rellenar este campo";
                            }
                            return null;
                          },
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
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              _errorMessage,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
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
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    widget.serverController.init(widget.context);
  }

  void _login(BuildContext context) async {
    if (!_loading) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        setState(() {
          _loading = true;
          _errorMessage = "";
        });

        User user = await widget.serverController.login(userName, password);
        if (user != null) {
          Navigator.of(context).pushReplacementNamed('/home', arguments: user);
        } else {
          setState(() {
            _loading = false;
            _errorMessage = "Contraseña o Usuario incorrectos";
          });
        }
      }
    }
  }

  _goToRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }
}
