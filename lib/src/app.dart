import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_project/src/connections/server_controller.dart';
import 'package:flutter_project/src/screens/home_screen.dart';
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
              return HomeScreen(_serverController);
            case "/register":
              User loggedUser = settings.arguments;
              return RegisterScreen(_serverController, context,
                  userToEdit: loggedUser);
            case "/my_recypes":
              return MyRecipesPage(_serverController);
            case "/my_favorites":
              return MyFavoritesPage(_serverController);
          }
          return LoginScreen(_serverController, context);
        });
      },
    );
  }
}
