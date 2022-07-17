import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:studiod/models/agendamento.dart';
import 'package:studiod/models/estabelecimento.dart';
import 'package:studiod/models/login.dart';
import 'package:studiod/models/perfil.dart';
import 'package:studiod/models/recuperar_senha.dart';

import '../../models/alterar_senha.dart';
import '../../models/horarios_disponiveis_agendamento.dart';
import '../../models/registrar.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/usuarios/autenticar")
  Future<RespostaLogin> autenticar(@Body() Login login);

  @POST("/usuarios/registrar")
  Future<RespostaRegistrar> registrar(@Body() Registrar registrar);

  @POST("/usuarios/recuperarSenha")
  Future<RespostaRecuperarSenha> recuperarSenha(
      @Body() RecuperarSenha recuperarSenha);

  @GET("/usuarios/perfil")
  Future<RespostaPerfil> obterPerfil(
      @Header("Authorization") String authorization);

  @POST("/usuarios/atualizarSenha")
  Future<RespostaAlterarSenha> atualizarSenha(
      @Header("Authorization") String authorization,
      @Body() AlterarSenha atualizarSenha);

  @GET("/estabelecimentos")
  Future<List<Estabelecimento>> obterEstabelecimentos(
      @Header("Authorization") String authorization);

  @GET("/agendamentos")
  Future<List<Agendamento>> obterAgendamentos(
      @Header("Authorization") String authorization);

  @GET("/agendamentos/horarios/{id_estabelecimento}")
  Future<List<HorariosDisponiveisAgendamento>> obterHorariosDisponiveis(
      @Header("Authorization") String authorization,
      @Path("id_estabelecimento") int idEstabelecimento);
}
