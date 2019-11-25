import 'package:flutter/material.dart';

class RegisterView  extends StatelessWidget {

  Function setNome;
  Function setCpf;
  Function setSenha;
  Function setNascimento;
  Function goToLogin;
  Function register;

  RegisterView({
    @required this.setNome,
    @required this.setCpf,
    @required this.setSenha,
    @required this.setNascimento,
    @required this.goToLogin,
    @required this.register,
  });

  TextStyle style = TextStyle(fontSize: 20.0);

  TextEditingController nascimentoFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final nameField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        hintText: "Nome",
        hintStyle: TextStyle(fontSize: 15),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black
        ),
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      onChanged: setNome,
    );

    final cpfField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        hintText: "CPF",
        hintStyle: TextStyle(fontSize: 15),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          ),
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
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      onChanged: setSenha,
    );

    var nascimentoField = TextField(
      controller: nascimentoFieldController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        hintText: "Data de Nascimento",
        hintStyle: TextStyle(fontSize: 15),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      onTap: () {
        print('test');
        showDatePicker(
          context: context,
          initialDatePickerMode: DatePickerMode.day,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData(primaryColor: Colors.indigo, accentColor: Colors.indigo),
              child: child,
            );
          },
        ).then((date) {
            if (date != null) {
              setNascimento(date.toIso8601String());
              nascimentoFieldController.value = TextEditingValue(text: '${date.day}/${date.month}/${date.year}');
              print(date.toIso8601String());
            }
          });

      }
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: 10000,
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: Text("Registrar",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.black, fontWeight: FontWeight.bold)
        ),
        onPressed: () {
          register(context);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Registre-se', style: style.apply(color: Colors.white),),
                    Divider(height: 40, thickness: 0,),
                    nameField,
                    Divider(height: 20, thickness: 0,),
                    cpfField,
                    Divider(height: 20, thickness: 0,),
                    passwordField,
                    Divider(height: 20, thickness: 0,),
                    nascimentoField,
                    Divider(height: 20, thickness: 0,),
                    registerButton,
                    Divider(height: 20, thickness: 0,),
                    Center(
                      child: FlatButton(
                        child: Text('ja possui uma conta? faça login', style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          goToLogin(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}