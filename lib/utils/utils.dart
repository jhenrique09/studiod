import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../services/api/status_resposta.dart';

String getApiBaseUrl() {
  if (kDebugMode) {
    return "http://10.9.9.11:3000/v1/";
  } else {
    return "https://api-studiod.jhenrique09.me/v1/";
  }
}

Future<bool> verificarConexao() async {
  await Future.delayed(const Duration(seconds: 1));
  return InternetConnectionChecker().hasConnection;
}

Future<StatusResposta> obterErroSemConexao(Acao acao) {
  return Future.error(StatusResposta(StatusRespostaCodigo.ERRO_SEM_CONEXAO,
      MensagensErro.ERRO_SEM_CONEXAO, acao));
}
