import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:studiod/models/login.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';

import '../utils/utils.dart';

GetIt sl = GetIt.instance;

class LoginService {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  static const String keyAutorizacao = "autorizacao";
  static const String keySenhaTemporaria = "senhaTemporaria";

  LoginService();

  Future<StatusResposta> validarLogin(String email, String senha) async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () async {
      if (!await verificarConexao()) {
        return obterErroSemConexao(Acao.LOGIN);
      }
      return sl<ApiService>()
          .autenticar(Login(email, senha))
          .then((value) async {
        await salvarToken(value.access_token);
        if (value.requer_atualizacao_senha) {
          await salvarSenhaTemporaria(senha);
          return StatusResposta(
              StatusRespostaCodigo.AUTENTICADO_SENHA_PROVISORIA,
              "Autenticado com sucesso com senha provisória.",
              Acao.LOGIN);
        }
        return StatusResposta(StatusRespostaCodigo.AUTENTICADO,
            "Autenticado com sucesso.", Acao.LOGIN);
      }).catchError((Object error) {
        return obterStatusRespostaErro(error, Acao.LOGIN);
      });
    });
  }

  Future<StatusResposta> validarLoginAtual() async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () async {
      if (await obterSenhaTemporaria() != null) {
        await logout();
      }
      if (!await verificarConexao()) {
        return obterErroSemConexao(Acao.LOGIN_JWT);
      }
      String? authorization = await obterToken();
      if (authorization == null) {
        return Future<StatusResposta>.error(StatusResposta(
            StatusRespostaCodigo.ERRO_TOKEN_NAO_DEFINIDO, "", Acao.LOGIN_JWT));
      }
      return sl<ApiService>().obterPerfil(authorization).then((value) async {
        if (value.requer_atualizacao_senha) {
          await logout();
          return StatusResposta(StatusRespostaCodigo.ERRO_NAO_AUTORIZADO,
              "Atualização de senha necessária.", Acao.LOGIN_JWT);
        }
        return StatusResposta(StatusRespostaCodigo.AUTENTICADO,
            "Perfil obtido com sucesso", Acao.LOGIN_JWT);
      }).catchError((Object error) async {
        await logout();
        return obterStatusRespostaErro(error, Acao.LOGIN_JWT);
      });
    });
  }

  logout() async {
    await storage.delete(key: keyAutorizacao);
    await storage.delete(key: keySenhaTemporaria);
  }

  salvarToken(String token) async {
    await storage.write(key: keyAutorizacao, value: "Bearer $token");
    await storage.delete(key: keySenhaTemporaria);
  }

  obterToken() async {
    return await storage.read(key: keyAutorizacao);
  }

  salvarSenhaTemporaria(String senhaTemporaria) async {
    await storage.write(key: keySenhaTemporaria, value: senhaTemporaria);
  }

  obterSenhaTemporaria() async {
    return await storage.read(key: keySenhaTemporaria);
  }
}
