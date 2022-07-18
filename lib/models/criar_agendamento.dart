import 'package:json_annotation/json_annotation.dart';

part 'criar_agendamento.g.dart';

@JsonSerializable()
class CriarAgendamento {
  int id_estabelecimento;
  String data;
  String hora;
  List<int> servicos;

  CriarAgendamento(
      {required this.id_estabelecimento,
      required this.data,
      required this.hora,
      required this.servicos});

  factory CriarAgendamento.fromJson(Map<String, dynamic> json) =>
      _$CriarAgendamentoFromJson(json);

  Map<String, dynamic> toJson() => _$CriarAgendamentoToJson(this);
}

@JsonSerializable()
class RespostaCriarAgendamento {
  int statusCode;
  String message;

  RespostaCriarAgendamento({required this.statusCode, required this.message});

  factory RespostaCriarAgendamento.fromJson(Map<String, dynamic> json) =>
      _$RespostaCriarAgendamentoFromJson(json);

  Map<String, dynamic> toJson() => _$RespostaCriarAgendamentoToJson(this);
}
