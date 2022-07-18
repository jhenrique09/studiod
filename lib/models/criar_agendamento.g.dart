// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criar_agendamento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CriarAgendamento _$CriarAgendamentoFromJson(Map<String, dynamic> json) =>
    CriarAgendamento(
      id_estabelecimento: json['id_estabelecimento'] as int,
      data: json['data'] as String,
      hora: json['hora'] as String,
      servicos:
          (json['servicos'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$CriarAgendamentoToJson(CriarAgendamento instance) =>
    <String, dynamic>{
      'id_estabelecimento': instance.id_estabelecimento,
      'data': instance.data,
      'hora': instance.hora,
      'servicos': instance.servicos,
    };

RespostaCriarAgendamento _$RespostaCriarAgendamentoFromJson(
        Map<String, dynamic> json) =>
    RespostaCriarAgendamento(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$RespostaCriarAgendamentoToJson(
        RespostaCriarAgendamento instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
    };
