import 'package:json_annotation/json_annotation.dart';

part 'horarios_disponiveis_agendamento.g.dart';

@JsonSerializable()
class HorariosDisponiveisAgendamento {
  String data;
  List<String> horarios;

  HorariosDisponiveisAgendamento({required this.data, required this.horarios});

  factory HorariosDisponiveisAgendamento.fromJson(Map<String, dynamic> json) =>
      _$HorariosDisponiveisAgendamentoFromJson(json);

  Map<String, dynamic> toJson() => _$HorariosDisponiveisAgendamentoToJson(this);
}
