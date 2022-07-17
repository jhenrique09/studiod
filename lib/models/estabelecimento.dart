import 'package:json_annotation/json_annotation.dart';
import 'package:string_mask/string_mask.dart';

import 'servico.dart';

part 'estabelecimento.g.dart';

@JsonSerializable()
class Estabelecimento {
  int id;
  String nome;
  String telefone;
  String endereco;
  String cep;
  String bairro;
  String cidade;
  String uf;
  String? referencia;
  String url_imagem;
  List<Servico> servicos;

  Estabelecimento(
      {required this.id,
      required this.nome,
      required this.telefone,
      required this.endereco,
      required this.cep,
      required this.bairro,
      required this.cidade,
      required this.uf,
      this.referencia,
      required this.url_imagem,
      required this.servicos});

  factory Estabelecimento.fromJson(Map<String, dynamic> json) =>
      _$EstabelecimentoFromJson(json);

  Map<String, dynamic> toJson() => _$EstabelecimentoToJson(this);

  String obterTelefoneFormatado() {
    return StringMask(
            telefone.length == 11 ? "(##) #####-####" : "(##) ####-####")
        .apply(telefone);
  }

  String obterCepFormatado() {
    return StringMask("#####-###").apply(cep);
  }

  String obterEnderecoCompleto(){
    String enderecoCompleto = "$endereco\n$bairro, $cidade - $uf\nCEP ${obterCepFormatado()}";
    if (referencia!.isEmpty){
      return enderecoCompleto;
    }else{
      return "$enderecoCompleto\n$referencia";
    }
  }
}
