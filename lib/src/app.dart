import 'package:flutter/material.dart';
import 'package:flutter_project/src/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.cyan,
          accentColor: Colors.cyan[300]),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/":
              return LoginScreen();
          }
          return LoginScreen();
        });
      },
    );
  }
}
