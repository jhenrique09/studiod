// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agendamento _$AgendamentoFromJson(Map<String, dynamic> json) => Agendamento(
      id: json['id'] as int,
      data: json['data'] as String,
      hora: json['hora'] as String,
      status: json['status'] as int,
      estabelecimento: AgendamentoEstabelecimento.fromJson(
          json['estabelecimento'] as Map<String, dynamic>),
      servicos: (json['servicos'] as List<dynamic>)
          .map((e) => Servico.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AgendamentoToJson(Agendamento instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'hora': instance.hora,
      'status': instance.status,
      'estabelecimento': instance.estabelecimento,
      'servicos': instance.servicos,
    };
