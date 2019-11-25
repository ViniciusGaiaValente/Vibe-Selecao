import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class DetailsView extends StatelessWidget {

  DetailsView({
    @required this.imagem,
    @required this.nome,
    @required this.vip,
    @required this.empresa,
    @required this.cpf,
    @required this.endereco,
    @required this.id
  });

  String nome;
  String imagem;
  String empresa;
  String cpf;
  String endereco;
  String id;
  bool vip;

  static Widget get loadingPage => Scaffold(
    backgroundColor: Colors.indigo,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text('Detalhes do Cliente'),
    ),
    body: Center(
      child: CircularProgressIndicator()
    ),
  );

  isVip() {
    if (vip) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: RichText(
              textAlign: TextAlign.center,
              maxLines: null,
              text: TextSpan(
                text: "V I P",
                style: TextStyle(fontSize: 16.0, color: Colors.black87),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Detalhes do Cliente'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 32),
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: (MediaQuery.of(context).size.width / 1.2),
                    margin: EdgeInsets.only(top: (MediaQuery.of(context).size.width / 4) + 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Divider(thickness: 0, height: (MediaQuery.of(context).size.width / 4),  color: Colors.white,),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: SelectableText.rich(
                            TextSpan(
                              text: nome,
                              style: TextStyle(fontSize: 20.0, color: Colors.black87),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: null,
                          ),
                        ),
                        isVip(),
                        Divider(height: 25, thickness: 0, color: Colors.white,),
                        Divider(height: 5, thickness: 1, color: Colors.black,),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: SelectableText.rich(
                            TextSpan(
                              text: 'Empresa: $empresa',
                              style: TextStyle(fontSize: 14.0, color: Colors.black87),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: null,
                          ),
                        ),
                        Divider(height: 5, thickness: 1, color: Colors.black,),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: SelectableText.rich(
                            TextSpan(
                              text: 'CPF: $cpf',
                              style: TextStyle(fontSize: 14.0, color: Colors.black87),
                            ),

                            textAlign: TextAlign.center,
                            maxLines: null,
                          ),
                        ),
                        Divider(height: 5, thickness: 1, color: Colors.black,),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: SelectableText.rich(
                            TextSpan(
                              text: 'Endereço: $endereco',
                              style: TextStyle(fontSize: 14.0, color: Colors.black87),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: null,
                          ),
                        ),
                        Divider(height: 5, thickness: 1, color: Colors.black,),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: SelectableText.rich(
                            TextSpan(
                              text: 'ID: $id',
                              style: TextStyle(fontSize: 14.0, color: Colors.black87),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: null,
                          ),
                        ),
                        Divider(height: 5, thickness: 0, color: Colors.white,),
                      ],
                    )
                  ),
                ]
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: imagem,
                    useOldImageOnUrlChange: false,
                    imageBuilder: (context, imageProvider) => Container(
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: new BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            spreadRadius: 8,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: new BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            spreadRadius: 8,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: new DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/client.jpg'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
