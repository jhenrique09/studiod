import 'package:json_annotation/json_annotation.dart';

part 'agendamento_estabelecimento.g.dart';

@JsonSerializable()
class AgendamentoEstabelecimento {
  int id;
  String nome;

  AgendamentoEstabelecimento({required this.id, required this.nome});

  factory AgendamentoEstabelecimento.fromJson(Map<String, dynamic> json) =>
      _$AgendamentoEstabelecimentoFromJson(json);

  Map<String, dynamic> toJson() => _$AgendamentoEstabelecimentoToJson(this);
}
