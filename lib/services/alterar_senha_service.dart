import 'package:get_it/get_it.dart';
import 'package:studiod/models/alterar_senha.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';
import 'package:studiod/services/login_service.dart';

import '../utils/utils.dart';

GetIt sl = GetIt.instance;

class AlterarSenhaService {
  LoginService loginService = LoginService();

  AlterarSenhaService();

  Future<StatusResposta> atualizarSenha(
      String? senhaAtual, String novaSenha) async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () async {
      if (!await verificarConexao()) {
        return obterErroSemConexao(Acao.ALTERAR_SENHA);
      }
      return sl<ApiService>()
          .atualizarSenha(
              await LoginService().obterToken(),
              AlterarSenha(
                  senhaAtual ?? await loginService.obterSenhaTemporaria(),
                  novaSenha))
          .then((value) async {
        await loginService.salvarToken(value.access_token);
        return StatusResposta(StatusRespostaCodigo.OK,
            "Senha atualizada com sucesso.", Acao.ALTERAR_SENHA);
      }).catchError((Object error) {
        return obterStatusRespostaErro(error, Acao.ALTERAR_SENHA);
      });
    });
  }
}
