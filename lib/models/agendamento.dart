import 'package:json_annotation/json_annotation.dart';
import 'package:studiod/models/agendamento_estabelecimento.dart';

import 'agendamento_servico.dart';

part 'agendamento.g.dart';

@JsonSerializable()
class Agendamento {
  int id;
  String data;
  String hora;
  int status;
  AgendamentoEstabelecimento estabelecimento;
  List<AgendamentoServico> servicos;

  Agendamento(
      {required this.id,
      required this.data,
      required this.hora,
      required this.status,
      required this.estabelecimento,
      required this.servicos});

  factory Agendamento.fromJson(Map<String, dynamic> json) =>
      _$AgendamentoFromJson(json);

  Map<String, dynamic> toJson() => _$AgendamentoToJson(this);
}
