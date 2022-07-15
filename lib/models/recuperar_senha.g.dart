// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recuperar_senha.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecuperarSenha _$RecuperarSenhaFromJson(Map<String, dynamic> json) =>
    RecuperarSenha(
      json['email'] as String,
    );

Map<String, dynamic> _$RecuperarSenhaToJson(RecuperarSenha instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

RespostaRecuperarSenha _$RespostaRecuperarSenhaFromJson(
        Map<String, dynamic> json) =>
    RespostaRecuperarSenha(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$RespostaRecuperarSenhaToJson(
        RespostaRecuperarSenha instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
    };
