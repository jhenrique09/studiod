import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:studiod/models/login.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';

GetIt sl = GetIt.instance;

class LoginService {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  static const String keyAutorizacao = "autorizacao";
  static const String keySenhaTemporaria = "senhaTemporaria";

  LoginService();

  Future<StatusResposta> validarLogin(String email, String senha) async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () {
      return sl<ApiService>()
          .autenticar(Login(email, senha))
          .then((value) async {
        await salvarToken(value.access_token);
        if (value.requer_atualizacao_senha){
          await salvarSenhaTemporaria(senha);
          return StatusResposta(
              StatusRespostaCodigo.AUTENTICADO_SENHA_PROVISORIA, "Autenticado com sucesso com senha provisória.");
        }
        return StatusResposta(
            StatusRespostaCodigo.AUTENTICADO, "Autenticado com sucesso.");
      }).catchError((Object error) {
        return obterStatusRespostaErro(error);
      });
    });
  }

  Future<StatusResposta> validarLoginAtual() async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () async {
      String? authorization = await obterToken();
      if (authorization == null) {
        return Future<StatusResposta>.error(
            StatusResposta(StatusRespostaCodigo.TOKEN_NAO_DEFINIDO, ""));
      }
      return sl<ApiService>().obterPerfil(authorization).then((value) async {
        if (await obterSenhaTemporaria() == null) {
          return StatusResposta(
              StatusRespostaCodigo.AUTENTICADO, "Perfil obtido com sucesso");
        }else{
          return StatusResposta(
              StatusRespostaCodigo.AUTENTICADO_SENHA_PROVISORIA, "Perfil obtido com sucesso");
        }
      }).catchError((Object error) async {
        await logout();
        return obterStatusRespostaErro(error);
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
