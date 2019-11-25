import 'package:flutter/material.dart';
import 'package:vibe/models/apiConnection.dart';
import 'package:vibe/models/sharedPreferences.dart';
import 'package:vibe/pages/home/homeController.dart';
import 'package:vibe/pages/login/loginView.dart';

class LoginController extends StatefulWidget {
  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {

  String cpf;
  String senha;

  setCpf(text) {
    cpf = text;
  }

  setSenha(text) {
    senha = text;
  }

  goToRegisterPage(context) {
    Navigator.pushNamed(context, '/register');
  }

  makeLogin(context) {

    ApiConnection.login(
      cpf: cpf,
      senha: senha,
      onSuccess: (token) {
        SharedPreferencesController.setToken(token)
          .then((res) {
            SharedPreferencesController.setCpf(cpf)
              .then((res) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeController(
                        token: token,
                        cpf: cpf,
                      );
                    },
                  ),
                );
              });
          });
      },
      onError: (message) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Ocorreu um erro"),
              content: Text(message),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('fechar'),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
                  },
                )
              ],
            );
          }
        );
      },
      onUnknownError: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Ocorreu um erro"),
              content: Text("Erro desconhecido"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('fechar'),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
                  },
                )
              ],
            );
          }
        );
      },
      onInvalidFields: (rules) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Ocorreu um erro"),
              content: Text(rules),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('fechar'),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
                  },
                )
              ],
            );
          }
        );
      },
      onInternetError: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Ocorreu um erro"),
                content: Text("Voce não esta conectado a internet, verifique sua conexão e tente novamente"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('fechar'),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
                    },
                  )
                ],
              );
            }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoginView(
      setCpf: this.setCpf,
      setSenha: this.setSenha,
      makeLogin: this.makeLogin,
      goToRegisterPage: this.goToRegisterPage,
    );
  }
}
