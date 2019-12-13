import 'package:flutter/material.dart';

typedef OnIngrendientDeleteCallback = void Function(int index);

class IngredientWidget extends StatelessWidget {
  final int index;
  final String ingredientName;
  final OnIngrendientDeleteCallback onIngrendientDeleteCallback;

  const IngredientWidget(
      {this.index,
      this.ingredientName,
      this.onIngrendientDeleteCallback,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backColor =
        (index % 2 == 0) ? Colors.blueGrey[300] : Colors.grey[300];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backColor,
      ),
      child: ListTile(
        leading: Text("${index + 1}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white)),
        title: Text(ingredientName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white)),
        trailing: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            onIngrendientDeleteCallback(index);
          },
        ),
      ),
    );
  }
}
