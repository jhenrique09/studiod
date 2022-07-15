import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:studiod/controllers/login_controller.dart';
import 'package:studiod/models/alterar_senha.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';

GetIt sl = GetIt.instance;
Logger logger = Logger();

class AlterarSenhaController {
  LoginController loginController = LoginController();

  AlterarSenhaController();

  Future<StatusResposta> atualizarSenha(
      String senhaAtual, String novaSenha) async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () async {
      return sl<ApiService>()
          .atualizarSenha(await LoginController().obterToken(),
              AlterarSenha(senhaAtual, novaSenha))
          .then((value) async {
        await loginController.salvarToken(value.access_token);
        return StatusResposta(
            StatusRespostaCodigo.OK, "Senha atualizada com sucesso.");
      }).catchError((Object error) {
        return obterStatusRespostaErro(error);
      });
    });
  }
}
