import 'package:flutter/material.dart';
import 'package:flutter_project/src/connections/server_controller.dart';

class MyDrawer extends StatelessWidget {
  final ServerController serverController;
  const MyDrawer({this.serverController, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1513151233558-d860c5398176?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
                    fit: BoxFit.cover)),
            accountName: Text(
              serverController.loggedUser.nickname,
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
                backgroundImage: FileImage(serverController.loggedUser.photo)),
            onDetailsPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/register',
                  arguments: serverController.loggedUser);
            },
          ),
          ListTile(
            title: Text("Mis Recetas", style: TextStyle(fontSize: 18)),
            leading: Icon(Icons.book, color: Colors.green),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/my_recipes');
            },
          ),
          ListTile(
            title: Text("Favoritos", style: TextStyle(fontSize: 18)),
            leading: Icon(Icons.favorite, color: Colors.red),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/my_favorites');
            },
          ),
          ListTile(
            title: Text("Cerra sesión", style: TextStyle(fontSize: 18)),
            leading: Icon(Icons.power_settings_new, color: Colors.grey),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, "/");
            },
          )
        ],
      ),
    );
  }
}
