import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {

  String nome;
  String cpf;
  DateTime nascimento;

  AccountView({ @required this.nome, @required this.cpf, @required this.nascimento });

  static Widget get loadingPage => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.indigo,
      title: Text("Sua Conta"),
    ),
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Sua Conta"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(26.0),
                padding: EdgeInsets.all(26.0),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2.0, 6.0),
                        blurRadius: 10,
                        spreadRadius: 10
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8),
                      child: SelectableText.rich(
                        TextSpan(
                          text: nome,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: null,
                      ),
                    ),
                    Divider(height: 25, thickness: 0, color: Colors.indigo,),
                    Divider(height: 5, thickness: 1, color: Colors.white,),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'CPF: $cpf',
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),

                        textAlign: TextAlign.center,
                        maxLines: null,
                      ),
                    ),
                    Divider(height: 5, thickness: 1, color: Colors.white,),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'Nascimento: ${nascimento.day}/${nascimento.month}/${nascimento.year}',
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: null,
                      ),
                    ),
                    Divider(height: 5, thickness: 0, color: Colors.indigo,),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}









