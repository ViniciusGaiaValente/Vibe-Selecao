import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibe/models/apiConnection.dart';
import 'package:vibe/models/sharedPreferences.dart';
import 'package:vibe/pages/details/detailsView.dart';

class DetailsController extends StatefulWidget {

  String nome;
  String cpf;
  String id;
  String token;
  bool vip;

  DetailsController({
    @required this.nome,
    @required this.cpf,
    @required this.id,
    @required this.token,
    @required this.vip
  });

  @override
  _DetailsControllerState createState() => _DetailsControllerState();
}

class _DetailsControllerState extends State<DetailsController> {

  Widget _content = DetailsView.loadingPage;

  getDetails(BuildContext context) {

    ApiConnection.showClient(
      token: widget.token,
      id: widget.id,
      onSuccess: (details) {
        var end = details['endereco'];
        setState(() {
          _content = DetailsView(
            nome: widget.nome,
            cpf: widget.cpf,
            id: widget.id,
            vip: widget.vip,
            empresa: details['empresa'],
            endereco: '${end['endereco']} ${end['numero']}, ${end['complemento']}, ${end['cidade']}',
            imagem: details['urlImagem'],
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
      },
      onUnknownError: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Ocorreu um Erro"),
              content: Text("Erro desconhecido"),
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
      }
    );
  }

  @override
  void initState() {
    getDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _content;
  }
}
