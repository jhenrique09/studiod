// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespostaPerfil _$RespostaPerfilFromJson(Map<String, dynamic> json) =>
    RespostaPerfil(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      id: json['id'] as int,
      nome: json['nome'] as String,
      email: json['email'] as String,
      requer_atualizacao_senha: json['requer_atualizacao_senha'] as bool,
      telefone: json['telefone'] as String,
      data_criacao: json['data_criacao'] as String,
      data_atualizacao: json['data_atualizacao'] as String,
    );

Map<String, dynamic> _$RespostaPerfilToJson(RespostaPerfil instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'id': instance.id,
      'nome': instance.nome,
      'email': instance.email,
      'requer_atualizacao_senha': instance.requer_atualizacao_senha,
      'telefone': instance.telefone,
      'data_criacao': instance.data_criacao,
      'data_atualizacao': instance.data_atualizacao,
    };
