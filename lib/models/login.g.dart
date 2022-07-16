// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      json['email'] as String,
      json['senha'] as String,
    );

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'email': instance.email,
      'senha': instance.senha,
    };

RespostaLogin _$RespostaLoginFromJson(Map<String, dynamic> json) =>
    RespostaLogin(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      access_token: json['access_token'] as String,
      requer_atualizacao_senha: json['requer_atualizacao_senha'] as bool,
    );

Map<String, dynamic> _$RespostaLoginToJson(RespostaLogin instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'access_token': instance.access_token,
      'requer_atualizacao_senha': instance.requer_atualizacao_senha,
    };
