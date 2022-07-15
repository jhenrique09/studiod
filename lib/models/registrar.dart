import 'package:json_annotation/json_annotation.dart';

part 'registrar.g.dart';

@JsonSerializable()
class Registrar {
  String nome;
  String email;
  String senha;
  String telefone;

  Registrar(this.nome, this.email, this.senha, this.telefone);

  factory Registrar.fromJson(Map<String, dynamic> json) =>
      _$RegistrarFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrarToJson(this);
}

@JsonSerializable()
class RespostaRegistrar {
  int statusCode;
  String message;
  String access_token;

  RespostaRegistrar(
      {required this.statusCode,
      required this.message,
      required this.access_token});

  factory RespostaRegistrar.fromJson(Map<String, dynamic> json) =>
      _$RespostaRegistrarFromJson(json);

  Map<String, dynamic> toJson() => _$RespostaRegistrarToJson(this);
}
