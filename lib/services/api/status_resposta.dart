import 'package:dio/dio.dart';

import '../../controllers/login_controller.dart';

class StatusResposta {
  StatusRespostaCodigo? codigo;
  String mensagem = "";

  StatusResposta(this.codigo, this.mensagem);
}

enum StatusRespostaCodigo {
  OK,
  ERRO_DESCONHECIDO,
  ERRO_INTERNO_SERVIDOR,
  ERRO_NAO_AUTORIZADO,
  TOKEN_NAO_DEFINIDO,
  REQUISICAO_INVALIDA,
}

String obterMensagemResposta(
    StatusRespostaCodigo? status, String? mensagemApi) {
  switch (status) {
    case StatusRespostaCodigo.OK:
      return "Ok.";
    case StatusRespostaCodigo.ERRO_INTERNO_SERVIDOR:
      return mensagemApi ?? "Erro interno do servidor.";
    case StatusRespostaCodigo.REQUISICAO_INVALIDA:
      return mensagemApi ?? "Requisição inválida.";
    case StatusRespostaCodigo.ERRO_NAO_AUTORIZADO:
      return "Email ou senha inválida.";
    default:
      return "Ocorreu um erro ao efetuar a operação.";
  }
}

Future<StatusResposta> obterStatusRespostaErro(Object error) {
  StatusResposta statusResposta =
      StatusResposta(StatusRespostaCodigo.ERRO_DESCONHECIDO, "");
  int codigoErro = 0;
  String? mensagem;
  switch (error.runtimeType) {
    case DioError:
      final res = (error as DioError).response;
      try {
        Map data = res?.data;
        codigoErro = data["statusCode"];
        if (data["message"] is String) {
          mensagem = data["message"];
        }
        if (data["message"] is List) {
          mensagem = data["message"][0];
        }
      } catch (e) {
        logger.e(e);
      }

      if (codigoErro == 400 || res?.statusCode == 400) {
        statusResposta.codigo = StatusRespostaCodigo.REQUISICAO_INVALIDA;
      } else if (codigoErro == 401 || res?.statusCode == 401) {
        statusResposta.codigo = StatusRespostaCodigo.ERRO_NAO_AUTORIZADO;
      } else if (codigoErro == 500 || res?.statusCode == 500) {
        statusResposta.codigo = StatusRespostaCodigo.ERRO_INTERNO_SERVIDOR;
      }
      break;
    default:
      logger.e(error);
      break;
  }
  statusResposta.mensagem =
      obterMensagemResposta(statusResposta.codigo, mensagem);
  return Future<StatusResposta>.error(statusResposta);
}