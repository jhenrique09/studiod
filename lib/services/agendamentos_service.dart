import 'package:get_it/get_it.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';
import 'package:studiod/services/login_service.dart';

import '../utils/utils.dart';

GetIt sl = GetIt.instance;

class AgendamentosService {
  AgendamentosService();

  Future<StatusResposta> obterAgendamentos() async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () async {
      if (!await verificarConexao()) {
        return obterErroSemConexao(Acao.AGENDAMENTOS);
      }
      String? authorization = await LoginService().obterToken();
      if (authorization == null) {
        return Future<StatusResposta>.error(StatusResposta(
            StatusRespostaCodigo.ERRO_TOKEN_NAO_DEFINIDO,
            "",
            Acao.AGENDAMENTOS));
      }
      return sl<ApiService>()
          .obterAgendamentos(authorization)
          .then((value) async {
        return StatusResposta(StatusRespostaCodigo.OK,
            "Dados obtidos com sucesso.", Acao.AGENDAMENTOS,
            retorno: value);
      }).catchError((Object error) {
        return obterStatusRespostaErro(error, Acao.AGENDAMENTOS);
      });
    });
  }
}
