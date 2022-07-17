import 'package:json_annotation/json_annotation.dart';

part 'agendamento_servico.g.dart';

@JsonSerializable()
class AgendamentoServico {
  int id;
  String nome;

  AgendamentoServico({required this.id, required this.nome});

  factory AgendamentoServico.fromJson(Map<String, dynamic> json) =>
      _$AgendamentoServicoFromJson(json);

  Map<String, dynamic> toJson() => _$AgendamentoServicoToJson(this);
}
