import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';
import 'package:flutter_project/src/components/ingredients_widget.dart';
import 'package:flutter_project/src/connections/server_controller.dart';

class DetailsPage extends StatefulWidget {
  final Recipe recipe;
  final ServerController serverController;
  DetailsPage({this.recipe, this.serverController, Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.help_outline),
                    onPressed: () {},
                  )
                ],
              )
            ];
          },
          body: TabBarView(
            children: <Widget>[
              IngredientsWidget(recipe: widget.recipe),
              Text("HEY")
            ],
          ),
        ),
      ),
    );
  }
}
