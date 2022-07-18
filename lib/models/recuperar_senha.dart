import 'package:json_annotation/json_annotation.dart';

part 'recuperar_senha.g.dart';

@JsonSerializable()
class RecuperarSenha {
  String email;

  RecuperarSenha(this.email);

  factory RecuperarSenha.fromJson(Map<String, dynamic> json) =>
      _$RecuperarSenhaFromJson(json);

  Map<String, dynamic> toJson() => _$RecuperarSenhaToJson(this);
}

@JsonSerializable()
class RespostaRecuperarSenha {
  int statusCode;
  String message;

  RespostaRecuperarSenha({required this.statusCode, required this.message});

  factory RespostaRecuperarSenha.fromJson(Map<String, dynamic> json) =>
      _$RespostaRecuperarSenhaFromJson(json);

  Map<String, dynamic> toJson() => _$RespostaRecuperarSenhaToJson(this);
}
