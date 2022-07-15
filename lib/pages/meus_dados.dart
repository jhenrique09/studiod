import 'package:flutter/material.dart';
import 'package:studiod/pages/alterar_senha.dart';

import '../services/login_service.dart';
import 'login.dart';

class MeusDados extends StatelessWidget {
  const MeusDados({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
      children: <Widget>[
        InkWell(
            onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AlterarSenha()))
                },
            child: const Card(
                child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: ListTile(
                      title: Text("Alterar senha"),
                      leading: Icon(Icons.key),
                    )))),
        InkWell(
            onTap: () async {
              await LoginService().logout();
              await Future.microtask(() => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const Login())));
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
