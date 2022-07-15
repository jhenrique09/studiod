import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:studiod/models/login.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/services/api/status_resposta.dart';

GetIt sl = GetIt.instance;
Logger logger = Logger();

class LoginController {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  static const String authorizationKey = "authorization";

  LoginController();

  Future<StatusResposta> validarLogin(String email, String senha) async {
    return Future<StatusResposta>.delayed(const Duration(seconds: 1), () {
      return sl<ApiService>()
          .autenticar(Login(email, senha))
          .then((value) async {
        await salvarToken(value.access_token);
        return StatusResposta(
            StatusRespostaCodigo.OK, "Autenticado com sucesso.");
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
        return StatusResposta(
            StatusRespostaCodigo.OK, "Perfil obtido com sucesso");
      }).catchError((Object error) async {
        await logout();
        return obterStatusRespostaErro(error);
      });
    });
  }

  logout() async {
    await storage.delete(key: authorizationKey);
  }

  salvarToken(String token) async {
    await storage.write(key: authorizationKey, value: "Bearer $token");
  }

  obterToken() async {
    return await storage.read(key: authorizationKey);
  }
}
