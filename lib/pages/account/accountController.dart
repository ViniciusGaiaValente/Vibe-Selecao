import 'package:flutter/material.dart';
import 'package:vibe/models/apiConnection.dart';
import 'package:vibe/models/sharedPreferences.dart';
import 'package:vibe/pages/account/accountView.dart';

class AccountController extends StatefulWidget {

  String token;
  String cpf;

  AccountController({ @required this.token, @required this.cpf });

  @override
  _AccountControllerState createState() => _AccountControllerState();
}

class _AccountControllerState extends State<AccountController> {

  Widget _content = AccountView.loadingPage;

  getAccount() {
    ApiConnection.showUser(
      token: widget.token,
      cpf: widget.cpf,
      onSuccess: (account) {
        setState(() {
          _content = AccountView(
            nome: account['nome'],
            cpf: account['cpf'],
            nascimento: DateTime.parse(account['nascimento']),
          );
        });
      },
        onInvalidToken: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Ocorreu um Erro"),
                  content: Text("Sua conexão expirou, por favor faça login novamente"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('fechar'),
                      onPressed: () {
                        SharedPreferencesController.setToken(null)
                            .then((res){
                          SharedPreferencesController.setList(null)
                              .then((res){
                            Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
                          });
                        });
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
                title: Text("Ocorreu um Erro"),
                content: Text("Voce não esta conectado a internet, para o acesso aos detalhes da sua conta é necessário estar conectado, por favor verifique sua conexão e faça login novamente"),
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
                title: Text("Ocorreu um Erro"),
                content: Text("Erro desconhecido, por favor faça login novamente"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('fechar'),
                    onPressed: () {
                      SharedPreferencesController.setToken(null)
                        .then((res){
                          SharedPreferencesController.setList(null)
                            .then((res) {
                              Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
                            });
                        });
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
  void initState() {
    getAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _content;
  }
}
