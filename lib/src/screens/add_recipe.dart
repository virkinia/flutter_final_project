import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project/src/components/image-picker.dart';
import 'package:flutter_project/src/components/ingredient.dart';
import 'package:flutter_project/src/connections/server_controller.dart';

import 'package:keyboard_visibility/keyboard_visibility.dart';

class AddRecipePage extends StatefulWidget {
  final ServerController serverController;
  AddRecipePage(this.serverController, {Key key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String name = '', description = '';
  List<String> ingredientsList = ['Tomate', 'Cebolla'], stepList = [];
  File photoFile;

  final nIngredientController = TextEditingController();
  final nPasoController = TextEditingController();

  bool _isWritting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva receta'),
      ),
      body: Form(
        key: formKey,
        child: Stack(
          children: <Widget>[
            ImagePickerWidget(
                imageFile: this.photoFile,
                onImageSelected: (File file) {
                  setState(() {
                    photoFile = file;
                  });
                }),
            Center(
              child: Transform.translate(
                offset: Offset(0, -20),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: (_isWritting ? 40 : 260),
                      bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: "Nombre de receta"),
                          onSaved: (value) {
                            this.name = value;
                          },
                          validator: (value) {
                            return value.trim().isEmpty
                                ? "Campo obligatorio"
                                : null;
                          },
                        ),
                        TextFormField(
                          maxLines: 6,
                          decoration: InputDecoration(labelText: "Descripción"),
                          onSaved: (value) {
                            this.description = value;
                          },
                          validator: (value) {
                            return value.trim().isEmpty
                                ? "Campo obligatorio"
                                : null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                            title: Text('Ingredientes'),
                            trailing: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _addIngrediente();
                                })),
                        SizedBox(
                          height: 20,
                        ),
                        getListIngredients()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isWritting = false;

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        _setWritting(visible);
      },
    );
  }

  _setWritting(bool value) {
    setState(() {
      _isWritting = value;
    });
  }

  Widget getListIngredients() {
    if (ingredientsList.isEmpty) {
      return Text("Introducir ingredientes");
    }
    return Column(
        children: List.generate(ingredientsList.length, (index) {
      final ingredient = ingredientsList[index];
      return IngredientWidget(
          index: index,
          ingredientName: ingredient,
          onIngrendientDeleteCallback: _onIngredientDelete);
    }));
  }

  void _onIngredientDelete(int index) {
    setState(() {
      ingredientsList.removeAt(index);
    });
  }

  void _addIngrediente() {
    final textController = TextEditingController();
    final save = () {
      final text = textController.text;

      if (text.trim().isEmpty) {
        showSnackBar("El nombre está vacío", backColor: Colors.orange);
        return;
      }

      setState(() {
        ingredientsList.add(text);
        Navigator.pop(context);
      });
    };
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Nuevo ingrediente"),
            content: TextField(
                controller: textController,
                decoration: InputDecoration(labelText: "Ingrediente"),
                onEditingComplete: save),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Añadir"),
                onPressed: save,
              )
            ],
          );
        });
  }

  void showSnackBar(String message, {MaterialColor backColor}) {
    scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(message), backgroundColor: backColor));
  }
}
