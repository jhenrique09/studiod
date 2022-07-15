// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alterar_senha.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlterarSenha _$AlterarSenhaFromJson(Map<String, dynamic> json) => AlterarSenha(
      json['senhaAtual'] as String,
      json['novaSenha'] as String,
    );

Map<String, dynamic> _$AlterarSenhaToJson(AlterarSenha instance) =>
    <String, dynamic>{
      'senhaAtual': instance.senhaAtual,
      'novaSenha': instance.novaSenha,
    };

RespostaAlterarSenha _$RespostaAlterarSenhaFromJson(
        Map<String, dynamic> json) =>
    RespostaAlterarSenha(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      access_token: json['access_token'] as String,
    );

Map<String, dynamic> _$RespostaAlterarSenhaToJson(
        RespostaAlterarSenha instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'access_token': instance.access_token,
    };
