import 'package:flutter/material.dart';
import 'package:vibe/models/apiConnection.dart';
import 'package:vibe/pages/register/registerView.dart';

class RegisterController extends StatefulWidget {
  @override
  _RegisterControllerState createState() => _RegisterControllerState();
}

class _RegisterControllerState extends State<RegisterController> {

  String nome;
  String cpf;
  String senha;
  String nascimento;

  setNome(text) {
    nome = text;
  }

  setCpf(text) {
    cpf = text;
  }

  setSenha(text) {
    senha = text;
  }

  setNascimento(text) {
    nascimento = text;
  }

  goToLogin(context) {
    Navigator.pop(context);
  }

  makeRegistration(context) {

    ApiConnection.register(
      nome: nome,
      cpf: cpf,
      senha: senha,
      nascimento: nascimento,
      onSuccess: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sucesso"),
              content: Text("Voce será redirencionado para a tela de login"),
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
                    Navigator.pop(context);
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
              content: Text("Erro deconhecido"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('fechar'),
                  onPressed: () {
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
                  },
                )
              ],
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegisterView(
      setNome: this.setNome,
      setCpf: this.setCpf,
      setSenha: this.setSenha,
      setNascimento: this.setNascimento,
      goToLogin: this.goToLogin,
      register: this.makeRegistration,
    );
  }
}
