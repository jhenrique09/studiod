import 'package:get_it/get_it.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';

import '../models/recuperar_senha.dart';
import '../utils/utils.dart';

GetIt sl = GetIt.instance;

class RecuperarSenhaService {
  RecuperarSenhaService();

  Future<StatusResposta> recuperarSenha(String email) async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () async {
      if (!await verificarConexao()) {
        return obterErroSemConexao(Acao.RECUPERAR_SENHA);
      }
      return sl<ApiService>()
          .recuperarSenha(RecuperarSenha(email))
          .then((value) async {
        return StatusResposta(
            StatusRespostaCodigo.OK,
            "Senha provisória enviada para o email cadastrado.",
            Acao.RECUPERAR_SENHA);
      }).catchError((Object error) {
        return obterStatusRespostaErro(error, Acao.RECUPERAR_SENHA);
      });
    });
  }
}
