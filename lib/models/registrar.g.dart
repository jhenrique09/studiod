// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registrar _$RegistrarFromJson(Map<String, dynamic> json) => Registrar(
      json['nome'] as String,
      json['email'] as String,
      json['senha'] as String,
      json['telefone'] as String,
    );

Map<String, dynamic> _$RegistrarToJson(Registrar instance) => <String, dynamic>{
      'nome': instance.nome,
      'email': instance.email,
      'senha': instance.senha,
      'telefone': instance.telefone,
    };

RespostaRegistrar _$RespostaRegistrarFromJson(Map<String, dynamic> json) =>
    RespostaRegistrar(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      access_token: json['access_token'] as String,
    );

Map<String, dynamic> _$RespostaRegistrarToJson(RespostaRegistrar instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'access_token': instance.access_token,
    };
