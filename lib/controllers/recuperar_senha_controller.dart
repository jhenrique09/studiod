import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:studiod/controllers/login_controller.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';

import '../models/recuperar_senha.dart';


GetIt sl = GetIt.instance;
Logger logger = Logger();

class RecuperarSenhaController {
  LoginController loginController = LoginController();

  RecuperarSenhaController();

  Future<StatusResposta> recuperarSenha(String email) async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () {
      return sl<ApiService>()
          .recuperarSenha(RecuperarSenha(email))
          .then((value) async {
        return StatusResposta(
            StatusRespostaCodigo.OK, "Senha provisória enviada para o email cadastrado.");
      }).catchError((Object error) {
        return obterStatusRespostaErro(error);
      });
    });
  }
}
