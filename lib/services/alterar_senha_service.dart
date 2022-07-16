import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:studiod/models/alterar_senha.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';
import 'package:studiod/services/login_service.dart';

GetIt sl = GetIt.instance;

class AlterarSenhaService {
  LoginService loginService = LoginService();

  AlterarSenhaService();

  Future<StatusResposta> atualizarSenha(
      String? senhaAtual, String novaSenha) async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () async {
      String senhatemp = await loginService.obterSenhaTemporaria();
      return sl<ApiService>()
          .atualizarSenha(await LoginService().obterToken(),
              AlterarSenha(senhaAtual ?? senhatemp, novaSenha))
          .then((value) async {
        await loginService.salvarToken(value.access_token);
        return StatusResposta(
            StatusRespostaCodigo.OK, "Senha atualizada com sucesso.");
      }).catchError((Object error) {
        return obterStatusRespostaErro(error);
      });
    });
  }
}
