import 'package:json_annotation/json_annotation.dart';

part 'alterar_senha.g.dart';

@JsonSerializable()
class AlterarSenha {
  String senhaAtual;
  String novaSenha;

  AlterarSenha(this.senhaAtual, this.novaSenha);

  factory AlterarSenha.fromJson(Map<String, dynamic> json) =>
      _$AlterarSenhaFromJson(json);

  Map<String, dynamic> toJson() => _$AlterarSenhaToJson(this);
}

@JsonSerializable()
class RespostaAlterarSenha {
  int statusCode;
  String message;
  String access_token;

  RespostaAlterarSenha(
      {required this.statusCode,
      required this.message,
      required this.access_token});

  factory RespostaAlterarSenha.fromJson(Map<String, dynamic> json) =>
      _$RespostaAlterarSenhaFromJson(json);

  Map<String, dynamic> toJson() => _$RespostaAlterarSenhaToJson(this);
}
