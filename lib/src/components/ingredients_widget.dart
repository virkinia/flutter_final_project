import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class IngredientsWidget extends StatelessWidget {
  final Recipe recipe;
  const IngredientsWidget({this.recipe, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        Text(
          this.recipe.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          this.recipe.description,
        ),
        SizedBox(height: 15),
        Text(
          "Ingredientes",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Column(
            children:
                List.generate(this.recipe.ingredients.length, (int index) {
          return ListTile(
              leading: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
              ),
              title: Text(this.recipe.ingredients[index]));
        }))
      ],
    );
  }
}
