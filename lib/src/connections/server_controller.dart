import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/modulo1_fake_backend.dart'
    as server;
import 'package:flutter_modulo1_fake_backend/models.dart';

class ServerController {
  void init(BuildContext context) {
    server.generateData(context);
  }

  Future<User> login(String nickname, String password) async {
    return await server.backendLogin(nickname, password);
  }
}
