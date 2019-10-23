import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_project/src/components/image-picker.dart';
import 'package:flutter_project/src/connections/server_controller.dart';

class RegisterScreen extends StatefulWidget {
  final ServerController serverController;
  final BuildContext context;

  RegisterScreen(this.serverController, this.context, {Key key})
      : super(key: key);

  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffKey = GlobalKey<ScaffoldState>();

  bool _loading = false;
  bool _showPassword = false;

  String userName = "";
  String password = "";
  String _errorMessage = "";
  Genrer genero = Genrer.MALE;

  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffKey,
        body: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              ImagePickerWidget(
                  imageFile: this.imageFile,
                  onImageSelected: (File file) {
                    setState(() {
                      imageFile = file;
                    });
                  }),
              SizedBox(
                height: kToolbarHeight + 24,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text("data"),
                ),
              ),
              Center(
                child: Transform.translate(
                  offset: Offset(0, -20),
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
                      child: ListView(
                        //mainAxisSize: MainAxisSize.min,
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
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Contraseña:",
                                suffixIcon: IconButton(
                                  icon: Icon(_showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                )),
                            obscureText: !_showPassword,
                            onSaved: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Debe rellenar este campo";
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Row(children: [
                            Expanded(
                              flex: 2,
                              child: Text("Género: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700])),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RadioListTile(
                                    title: Text("Masculino"),
                                    value: Genrer.MALE,
                                    groupValue: genero,
                                    onChanged: (value) {
                                      setState(() {
                                        genero = value;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text("Femenino"),
                                    value: Genrer.FEMALE,
                                    groupValue: genero,
                                    onChanged: (value) {
                                      setState(() {
                                        genero = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(accentColor: Colors.white),
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              onPressed: () => _register(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Registrar'),
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
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _register(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (this.imageFile == null) {
        showSnackbar(context, "Añade una foto para tener un perfil rechulon",
            Colors.orange);
        return;
      }
      User user = User(
          genrer: this.genero,
          nickname: this.userName,
          password: this.password,
          photo: this.imageFile);

      final state = await widget.serverController.addUser(user);

      if (!state) {
        showSnackbar(context, "No se ha guardado", Colors.orange);
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Información"),
                content: Text("Su usuario ha sido registrado correctamente"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    }
  }

  void showSnackbar(BuildContext context, String title, Color backColor) {
    _scaffKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        title,
        textAlign: TextAlign.center,
      ),
      backgroundColor: backColor,
    ));
  }
}
