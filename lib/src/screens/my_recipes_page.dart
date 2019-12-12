import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_project/src/components/recipe_widget.dart';
import 'package:flutter_project/src/connections/server_controller.dart';

class MyRecipesPage extends StatefulWidget {
  final ServerController serverController;

  MyRecipesPage(this.serverController, {Key key}) : super(key: key);

  _MyRecipesPageState createState() => _MyRecipesPageState();
}

class _MyRecipesPageState extends State<MyRecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis recetas"),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: widget.serverController.getUserRecipesList(),
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
                        "No se encontró ninguna receta en su biblioteca, puede agregar una receta desde la pantalla principal",
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('HOLA HE LLEGAGO: ');
  }
}
