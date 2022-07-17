// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horarios_disponiveis_agendamento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HorariosDisponiveisAgendamento _$HorariosDisponiveisAgendamentoFromJson(
        Map<String, dynamic> json) =>
    HorariosDisponiveisAgendamento(
      data: json['data'] as String,
      horarios:
          (json['horarios'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HorariosDisponiveisAgendamentoToJson(
        HorariosDisponiveisAgendamento instance) =>
    <String, dynamic>{
      'data': instance.data,
      'horarios': instance.horarios,
    };
