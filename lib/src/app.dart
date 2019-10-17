import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_project/src/connections/server_controller.dart';
import 'package:flutter_project/src/screens/home_screen.dart';
import 'package:flutter_project/src/screens/login_screen.dart';
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
          appBarTheme:
              AppBarTheme(iconTheme: IconThemeData(color: Colors.white))),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/":
              return LoginScreen(_serverController, context);
            case "/home":
              User logged = settings.arguments;
              return HomeScreen(logged);
            case "/register":
              return RegisterScreen(_serverController, context);
          }
          return LoginScreen(_serverController, context);
        });
      },
    );
  }
}
