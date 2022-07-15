import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:studiod/models/login.dart';
import 'package:studiod/models/perfil.dart';
import 'package:studiod/models/recuperar_senha.dart';

import '../../models/registrar.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://10.9.9.11:3000/v1/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/usuarios/autenticar")
  Future<RespostaLogin> autenticar(@Body() Login login);

  @GET("/usuarios/perfil")
  Future<RespostaPerfil> obterPerfil(
      @Header("Authorization") String authorization);

  @POST("/usuarios/registrar")
  Future<RespostaRegistrar> registrar(@Body() Registrar registrar);

  @POST("/usuarios/recuperarSenha")
  Future<RespostaRecuperarSenha> recuperarSenha(@Body() RecuperarSenha recuperarSenha);
}
