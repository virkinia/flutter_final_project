import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class PreparationWidget extends StatelessWidget {
  final Recipe recipe;
  const PreparationWidget({this.recipe, Key key}) : super(key: key);

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
          "Preparación",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Column(
            children: List.generate(this.recipe.steps.length, (int index) {
          return ListTile(
              leading: Text(
                "${index + 1}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).primaryColor),
              ),
              title: Text(this.recipe.steps[index]));
        }))
      ],
    );
  }
}
