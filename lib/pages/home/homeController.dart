import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vibe/models/apiConnection.dart';
import 'package:vibe/models/sharedPreferences.dart';
import 'package:vibe/pages/account/accountController.dart';
import 'package:vibe/pages/details/detailsController.dart';
import 'package:vibe/pages/home/homeView.dart';

class HomeController extends StatefulWidget {

  String token;
  String cpf;

  HomeController({ @required this.token, @required this.cpf });

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {

  Widget _content = HomeView.loadingPage;

  logout() {
    SharedPreferencesController.setToken(null)
      .then((res){
        SharedPreferencesController.setList(null)
          .then((res){
            Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
          });
      });
  }

  goToAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AccountController(
            token: widget.token,
            cpf: widget.cpf,
          );
        },
      ),
    );
  }

  goToDetails({
    @required String nome,
    @required String cpf,
    @required String id,
    @required bool vip
  }) {

    SharedPreferencesController.checkConnection()
      .then((connected) {
        if (connected) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsController(
                nome: nome,
                cpf: cpf,
                id: id,
                vip: vip,
                token: widget.token,
              ),
            ),
          );
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Ocorreu um Erro"),
                content: Text("Voce não esta conectado a internet, para o acesso aos detalhes do cliente é necessário estar conectado, por favor verifique sua conexão e faça login novamente"),
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
        }
      });
  }

  loadClients() {

    SharedPreferencesController.checkConnection()
      .then((connected) {
        if (!connected) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Ocorreu um Erro"),
                content: Text("Para atualizar a lista voce precisa se conectar a internet"),
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
        } else {
          getClients();
        }
      });
  }

  getClients() {

    setState(() {
      _content = HomeView.loadingPage;
    });

    ApiConnection.listClients(
        token: widget.token,
        onSuccess: (list) {
          SharedPreferencesController.setList(jsonEncode(list))
            .then((res) {
              setState(() {
                _content = HomeView(
                  clientsList: list,
                  logout: logout,
                  goToAccount: goToAccount,
                  goToDetails: goToDetails,
                  loadClients: loadClients,
                );
              });
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
          SharedPreferencesController.getList()
            .then((list) {
              if (list != null) {
                setState(() {
                  _content = HomeView(
                    clientsList: jsonDecode(list),
                    logout: logout,
                    goToAccount: goToAccount,
                    goToDetails: goToDetails,
                    loadClients: loadClients,
                  );
                });
              } else {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Ocorreu um Erro"),
                      content: Text("Voce não esta conectado a internet e não foi encontrada nenhuma listagem anterior salva, por favor, verifique sua conexão e faça login novamente"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('fechar'),
                          onPressed: () {
                            SharedPreferencesController.setToken(null)
                              .then((res){
                                Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
                              });
                          },
                        )
                      ],
                    );
                  }
                );
              }
            });
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
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
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
    getClients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _content;
  }
}
