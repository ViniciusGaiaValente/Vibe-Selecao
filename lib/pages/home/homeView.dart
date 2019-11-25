import 'package:flutter/material.dart';
import 'package:vibe/models/sharedPreferences.dart';

class HomeView extends StatelessWidget {

  List<dynamic> clientsList;
  Function loadClients;
  Function logout;
  Function goToAccount;
  Function goToDetails;

  HomeView({
    @required this.clientsList,
    @required this.loadClients,
    @required this.logout,
    @required this.goToAccount,
    @required this.goToDetails,
  });

  static Widget get loadingPage => Scaffold(
    appBar: AppBar(
      title: Text('Clientes'),
      backgroundColor: Colors.indigo,
      leading: PopupMenuButton(
        itemBuilder: (context){
          return [];
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: (){},
        ),
      ],
    ),
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: loadClients,
          ),
        ],
        leading: PopupMenuButton<String>(
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Fazer Logout'),
              ),
              PopupMenuItem<String>(
                value: 'Account',
                child: Text('Minha Conta'),
              ),
            ];
          },
          onSelected: (option) {
            if (option == 'Logout') {
              logout();
            } else if (option == 'Account') {
              goToAccount();
            }
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          if (i < clientsList.length) {

            var cliente = clientsList[i];

            var nome = cliente['nome'];
            var cpf = cliente['cpf'];
            var id = cliente['id'];
            var vip = cliente['especial'];

            return Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Colors.black, style: BorderStyle.solid))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SelectableText.rich(
                          TextSpan(
                            text: nome,
                            style: TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                          maxLines: null,
                        ),
                        Divider(height: 10, thickness: 0,),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          child: SelectableText.rich(
                            TextSpan(
                              text: "CPF: $cpf",
                              style: TextStyle(fontSize: 14.0, color: Colors.black87),
                            ),
                            enableInteractiveSelection: true,
                            maxLines: null,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          child: RichText(
                            text:TextSpan(
                              text: "ID: $id",
                              style: TextStyle(fontSize: 14.0, color: Colors.black87),
                            ),
                            overflow: TextOverflow.visible,
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      goToDetails(
                        nome: nome,
                        cpf: cpf,
                        id: id,
                        vip: vip,
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return null;
          }
        }
      ),
    );
  }
}
