import 'package:json_annotation/json_annotation.dart';

part 'perfil.g.dart';

@JsonSerializable()
class RespostaPerfil {
  int statusCode;
  String message;
  int id;
  String nome;
  String email;
  bool requer_atualizacao_senha;
  String telefone;
  String data_criacao;
  String data_atualizacao;

  RespostaPerfil(
      {required this.statusCode,
      required this.message,
      required this.id,
      required this.nome,
      required this.email,
      required this.requer_atualizacao_senha,
      required this.telefone,
      required this.data_criacao,
      required this.data_atualizacao});

  factory RespostaPerfil.fromJson(Map<String, dynamic> json) =>
      _$RespostaPerfilFromJson(json);

  Map<String, dynamic> toJson() => _$RespostaPerfilToJson(this);
}
