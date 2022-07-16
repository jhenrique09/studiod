import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class StatusResposta {
  StatusRespostaCodigo codigo = StatusRespostaCodigo.OK;
  String mensagem = "";
  Acao acao;

  StatusResposta(this.codigo, this.mensagem, this.acao);
}

enum StatusRespostaCodigo {
  OK,
  AUTENTICADO,
  AUTENTICADO_SENHA_PROVISORIA,
  ERRO_DESCONHECIDO,
  ERRO_INTERNO_SERVIDOR,
  ERRO_NAO_AUTORIZADO,
  ERRO_TOKEN_NAO_DEFINIDO,
  ERRO_REQUISICAO_INVALIDA,
  ERRO_SEM_CONEXAO,
}

enum Acao {
  LOGIN,
  LOGIN_JWT,
  REGISTRAR,
  ALTERAR_SENHA,
  RECUPERAR_SENHA,
}

class MensagensErro {
  static String ERRO_INTERNO_SERVIDOR = "Erro interno do servidor.";
  static String ERRO_REQUISICAO_INVALIDA = "Requisição inválida.";
  static String ERRO_NAO_AUTORIZADO = "E-mail ou senha inválidos.";
  static String ERRO_SEM_CONEXAO = "Sem conexão com a internet.";
  static String ERRO_DESCONHECIDO = "Ocorreu um erro ao efetuar a operação.";
}

String obterMensagemResposta(
    StatusRespostaCodigo? status, String? mensagemApi) {
  switch (status) {
    case StatusRespostaCodigo.OK:
      return "Ok.";
    case StatusRespostaCodigo.ERRO_INTERNO_SERVIDOR:
      return mensagemApi ?? MensagensErro.ERRO_INTERNO_SERVIDOR;
    case StatusRespostaCodigo.ERRO_REQUISICAO_INVALIDA:
      return mensagemApi ?? MensagensErro.ERRO_REQUISICAO_INVALIDA;
    case StatusRespostaCodigo.ERRO_NAO_AUTORIZADO:
      return MensagensErro.ERRO_NAO_AUTORIZADO;
    case StatusRespostaCodigo.ERRO_SEM_CONEXAO:
      return MensagensErro.ERRO_SEM_CONEXAO;
    case StatusRespostaCodigo.ERRO_TOKEN_NAO_DEFINIDO:
    case StatusRespostaCodigo.AUTENTICADO:
    case StatusRespostaCodigo.AUTENTICADO_SENHA_PROVISORIA:
      return "";
    default:
      return MensagensErro.ERRO_DESCONHECIDO;
  }
}

Future<StatusResposta> obterStatusRespostaErro(Object error, Acao acao) async {
  Logger logger = Logger();
  StatusResposta statusResposta =
      StatusResposta(StatusRespostaCodigo.ERRO_DESCONHECIDO, "", acao);
  String? mensagem;
  logger.e(error);
  int codigoErro = 0;
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
        statusResposta.codigo = StatusRespostaCodigo.ERRO_REQUISICAO_INVALIDA;
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
