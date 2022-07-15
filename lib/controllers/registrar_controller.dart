import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:studiod/controllers/login_controller.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';

import '../models/registrar.dart';

GetIt sl = GetIt.instance;
Logger logger = Logger();

class RegistrarController with ChangeNotifier {
  LoginController loginController = LoginController();

  RegistrarController();

  Future<StatusResposta> registrar(
      String nome, String email, String senha, String telefone) async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () {
      return sl<ApiService>()
          .registrar(Registrar(nome, email, senha, telefone))
          .then((value) async {
        await loginController.salvarToken(value.access_token);
        return StatusResposta(
            StatusRespostaCodigo.OK, "Registrado com sucesso.");
      }).catchError((Object error) {
        return obterStatusRespostaErro(error);
      });
    });
  }
}
