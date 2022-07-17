import 'package:get_it/get_it.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';
import 'package:studiod/services/login_service.dart';

import '../utils/utils.dart';

GetIt sl = GetIt.instance;

class EstabelecimentosService {
  EstabelecimentosService();

  Future<StatusResposta> obterEstabelecimentos() async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () async {
      if (!await verificarConexao()) {
        return obterErroSemConexao(Acao.ESTABELECIMENTOS);
      }
      String? authorization = await LoginService().obterToken();
      if (authorization == null) {
        return Future<StatusResposta>.error(StatusResposta(
            StatusRespostaCodigo.ERRO_TOKEN_NAO_DEFINIDO,
            "",
            Acao.ESTABELECIMENTOS));
      }
      return sl<ApiService>()
          .obterEstabelecimentos(authorization)
          .then((value) async {
        return StatusResposta(StatusRespostaCodigo.OK,
            "Dados obtidos com sucesso.", Acao.ESTABELECIMENTOS,
            retorno: value);
      }).catchError((Object error) {
        return obterStatusRespostaErro(error, Acao.ESTABELECIMENTOS);
      });
    });
  }
}
