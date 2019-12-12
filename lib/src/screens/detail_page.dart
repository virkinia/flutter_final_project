import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';
import 'package:flutter_project/src/components/ingredients_widget.dart';
import 'package:flutter_project/src/components/preparation_widget.dart';
import 'package:flutter_project/src/connections/server_controller.dart';

class DetailsPage extends StatefulWidget {
  final Recipe recipe;
  final ServerController serverController;
  DetailsPage({this.recipe, this.serverController, Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool favorite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(widget.recipe.name),
                expandedHeight: 320,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(widget.recipe.photo))),
                ),
                pinned: true,
                bottom: TabBar(
                  labelColor: Colors.white,
                  indicatorWeight: 4,
                  tabs: <Widget>[
                    Tab(
                      child: Text('Ingredientes'),
                    ),
                    Tab(
                      child: Text('Preparación'),
                    )
                  ],
                ),
                actions: <Widget>[
                  getFavoriteWidget(),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.help_outline),
                    onPressed: () {
                      _showAboutIt(context);
                    },
                  )
                ],
              )
            ];
          },
          body: TabBarView(
            children: <Widget>[
              IngredientsWidget(recipe: widget.recipe),
              PreparationWidget(recipe: widget.recipe),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFavoriteWidget() {
    if (favorite != null) {
      return IconButton(
        icon: Icon(Icons.favorite, color: favorite ? Colors.red : Colors.white),
        onPressed: () async {
          await (!favorite
              ? widget.serverController.addFavorite(widget.recipe)
              : widget.serverController.deleteFavorite(widget.recipe));
          setState(() {
            favorite = !favorite;
          });
        },
      );
    }

    return Container(
        margin: EdgeInsets.all(15),
        width: 25,
        child: CircularProgressIndicator());
  }

  @override
  void initState() {
    super.initState();
    this.loadState();
  }

  loadState() async {
    final state = await widget.serverController.getIsFavorite(widget.recipe);
    setState(() {
      this.favorite = state;
    });
  }

  void _showAboutIt(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Acerca de la receta"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: <Widget>[
                    Text("Nombre: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.recipe.name)
                  ]),
                  Row(children: <Widget>[
                    Text("Usuario: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.recipe.user.nickname)
                  ]),
                  Row(children: <Widget>[
                    Text("Fecha de publicación ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        "${widget.recipe.date.day}/${widget.recipe.date.month}/${widget.recipe.date.year}")
                  ])
                ],
              ));
        });
  }
}
