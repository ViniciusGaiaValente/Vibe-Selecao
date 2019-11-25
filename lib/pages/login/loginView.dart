import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {

  TextStyle style = TextStyle(fontSize: 20.0);

  Function setCpf;
  Function setSenha;
  Function makeLogin;
  Function goToRegisterPage;

  LoginView({ this.setCpf, this.setSenha, this.makeLogin, this.goToRegisterPage });

  @override
  Widget build(BuildContext context) {

    final cpfField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        hintText: "CPF",
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      onChanged: setCpf,
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        hintText: "Senha",
        hintStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        ),
      ),
      onChanged: setSenha,
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.indigo,
      child: MaterialButton(
        minWidth: 10000,
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)
        ),
        onPressed: () {
          makeLogin(context);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/logo.png', height:150, width: 150),
              Container(
                margin: EdgeInsets.all(26.0),
                padding: EdgeInsets.all(26.0),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Fazer Login', style: style,),
                    Divider(height: 40, thickness: 0,),
                    cpfField,
                    Divider(height: 20, thickness: 0,),
                    passwordField,
                    Divider(height: 20, thickness: 0,),
                    loginButton,
                    Divider(height: 20, thickness: 0,),
                    Center(
                      child: FlatButton(
                        child: Text('Ainda não possui uma conta? Registre-se'),
                        onPressed: () {
                          goToRegisterPage(context);
                        },
                      ),
                    ),
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
