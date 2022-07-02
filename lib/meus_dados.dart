import 'package:flutter/material.dart';

class MeusDados extends StatelessWidget {
  const MeusDados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
      children: <Widget>[
        InkWell(
            onTap: () => {Navigator.pushNamed(context, 'alterar_senha')},
            child: const Card(
                child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: ListTile(
                      title: Text("Alterar senha"),
                      leading: Icon(Icons.key),
                    )))),
        InkWell(
            onTap: () => {
              Navigator.pushReplacementNamed(context, 'login')
            },
            child: const Card(
                child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: ListTile(
                      title: Text("Sair"),
                      leading: Icon(Icons.logout),
                    ))))
      ],
    );
  }
}
