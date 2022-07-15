import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studiod/services/api/status_resposta.dart';

import '../services/login_service.dart';
import 'login.dart';

class PaginaInternaState<T extends StatefulWidget> extends State<T> {
  Future<bool> handleStatusResposta(
      BuildContext context, StatusResposta statusResposta) async {
    if (statusResposta.codigo == StatusRespostaCodigo.ERRO_NAO_AUTORIZADO) {
      await LoginService().logout();
      await Future.microtask(() => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const Login()), (route) => false));
      return Future.error(true);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
