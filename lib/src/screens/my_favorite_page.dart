import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_project/src/components/recipe_widget.dart';
import 'package:flutter_project/src/connections/server_controller.dart';

class MyFavoritesPage extends StatefulWidget {
  final ServerController serverController;

  MyFavoritesPage(this.serverController, {Key key}) : super(key: key);

  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis favoritos"),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: widget.serverController.getFavoritesList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Recipe> list = snapshot.data;

            if (list.length == 0) {
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.info,
                        size: 120,
                        color: Colors.grey[300],
                      ),
                      Text(
                        "Su listado de favoritos está vacío, para poder agregar a favoritos simplemente seleccione el ícono de favorito(corazón) en la receta que desee agregar",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                Recipe recipe = list[index];

                return RecipeWidget(
                  recipe: recipe,
                  serverController: widget.serverController,
                  onChange: () {
                    setState(() {});
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
