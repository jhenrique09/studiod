import 'package:get_it/get_it.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';
import 'package:studiod/services/login_service.dart';

import '../models/registrar.dart';
import '../utils/utils.dart';

GetIt sl = GetIt.instance;

class RegistrarUsuarioService {
  LoginService loginService = LoginService();

  RegistrarUsuarioService();

  Future<StatusResposta> registrar(
      String nome, String email, String senha, String telefone) async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () async {
      if (!await verificarConexao()) {
        return obterErroSemConexao(Acao.REGISTRAR);
      }
      return sl<ApiService>()
          .registrar(Registrar(nome, email, senha, telefone))
          .then((value) async {
        await loginService.salvarToken(value.access_token);
        return StatusResposta(
            StatusRespostaCodigo.OK, "Registrado com sucesso.", Acao.REGISTRAR);
      }).catchError((Object error) {
        return obterStatusRespostaErro(error, Acao.REGISTRAR);
      });
    });
  }
}
