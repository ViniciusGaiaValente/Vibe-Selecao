import 'package:flutter/material.dart';
import 'package:vibe/models/sharedPreferences.dart';
import 'package:vibe/pages/login/loginController.dart';
import 'package:vibe/pages/home/homeController.dart';
import 'package:vibe/pages/register/resgisterController.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Widget _page = Container();

  @override
  initState() {
    SharedPreferencesController.getToken()
      .then((token) {
        SharedPreferencesController.getCpf()
          .then((cpf) {
          if (token == null || cpf == null) {
            setState(() {
              _page = LoginController();
            });
          } else {
            setState(() {
              _page = _page = HomeController(token: token, cpf: cpf,);
            });
          }
          });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/root': (context) => MyApp(),
        '/login': (context) => LoginController(),
        '/register': (context) => RegisterController(),
      },
      home: _page,
    );
  }
}