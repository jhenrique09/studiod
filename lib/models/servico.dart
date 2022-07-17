import 'package:json_annotation/json_annotation.dart';

part 'servico.g.dart';

@JsonSerializable()
class Servico {
  int id;
  String nome;

  Servico({required this.id, required this.nome});

  factory Servico.fromJson(Map<String, dynamic> json) =>
      _$ServicoFromJson(json);

  Map<String, dynamic> toJson() => _$ServicoToJson(this);
}
