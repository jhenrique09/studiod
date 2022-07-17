// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estabelecimento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Estabelecimento _$EstabelecimentoFromJson(Map<String, dynamic> json) =>
    Estabelecimento(
      id: json['id'] as int,
      nome: json['nome'] as String,
      telefone: json['telefone'] as String,
      endereco: json['endereco'] as String,
      cep: json['cep'] as String,
      bairro: json['bairro'] as String,
      cidade: json['cidade'] as String,
      uf: json['uf'] as String,
      referencia: json['referencia'] as String?,
      url_imagem: json['url_imagem'] as String,
      servicos: (json['servicos'] as List<dynamic>)
          .map((e) => Servico.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EstabelecimentoToJson(Estabelecimento instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'telefone': instance.telefone,
      'endereco': instance.endereco,
      'cep': instance.cep,
      'bairro': instance.bairro,
      'cidade': instance.cidade,
      'uf': instance.uf,
      'referencia': instance.referencia,
      'url_imagem': instance.url_imagem,
      'servicos': instance.servicos,
    };
