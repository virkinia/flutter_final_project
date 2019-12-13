import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_project/src/connections/server_controller.dart';
import 'package:flutter_project/src/screens/add_recipe.dart';
import 'package:flutter_project/src/screens/detail_page.dart';
import 'package:flutter_project/src/screens/home_page.dart';

import 'package:flutter_project/src/screens/login_screen.dart';

import 'package:flutter_project/src/screens/my_favorite_page.dart';
import 'package:flutter_project/src/screens/my_recipes_page.dart';

import 'package:flutter_project/src/screens/register_screen.dart';

ServerController _serverController = ServerController();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.cyan,
          accentColor: Colors.cyan[300],
          accentIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(title: TextStyle(color: Colors.white)),
              iconTheme: IconThemeData(color: Colors.white))),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/":
              return LoginScreen(_serverController, context);
            case "/home":
              User loggedUser = settings.arguments;
              _serverController.loggedUser = loggedUser;
              return HomePage(_serverController);
            case "/register":
              User loggedUser = settings.arguments;
              return RegisterScreen(_serverController, context,
                  userToEdit: loggedUser);
            case "/my_recipes":
              return MyRecipesPage(_serverController);
            case "/my_favorites":
              return MyFavoritesPage(_serverController);
            case "/details":
              Recipe recipe = settings.arguments;
              return DetailsPage(
                  recipe: recipe, serverController: _serverController);
            case "/add_recipe":
              return AddRecipePage(_serverController);
          }
          return LoginScreen(_serverController, context);
        });
      },
    );
  }
}
