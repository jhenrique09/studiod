import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:studiod/models/estabelecimento.dart';
import 'package:studiod/pages/agendamento.dart';
import 'package:studiod/services/estabelecimentos_service.dart';
import 'package:studiod/widgets/erro_ao_carregar.dart';
import 'package:studiod/widgets/shimmer_loader.dart';

import '../services/api/status_resposta.dart';
import '../widgets/sem_conexao.dart';

class Estabelecimentos extends StatefulWidget {
  VoidCallback callbackRecarregar;
  Estabelecimentos({Key? key, required this.callbackRecarregar}) : super(key: key);

  @override
  State<Estabelecimentos> createState() => _EstabelecimentosState();
}

class _EstabelecimentosState extends State<Estabelecimentos> {
  Future<StatusResposta>? futureEstabelecimentos;
  Logger logger = Logger();

  Future<void> atualizar() async {
    Future.microtask(() => setState(() {
          futureEstabelecimentos =
              EstabelecimentosService().obterEstabelecimentos();
        }));
  }

  Widget exibirEstabelecimentos(List<Estabelecimento> estabelecimentos) {
    return RefreshIndicator(
        onRefresh: atualizar,
        child: ListView.builder(
            itemCount: estabelecimentos.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
                  child: InkWell(
                      onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Agendamento(
                                        estabelecimento:
                                            estabelecimentos[index], callbackEstabelecimento: widget.callbackRecarregar,)))
                          },
                      child: Card(
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 2.0, bottom: 2.0),
                              child: ListTile(
                                  title: Text(estabelecimentos[index].nome),
                                  subtitle: Text(
                                      "${estabelecimentos[index].bairro}, ${estabelecimentos[index].cidade} - ${estabelecimentos[index].uf}"),
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          estabelecimentos[index]
                                              .url_imagem)))))));
            }));
  }

  Widget shimmerLoader() {
    return ShimmerLoader(const Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 6.0),
        child: Card(
            child: Padding(
                padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                child: ListTile(title: Text(""), subtitle: Text(""))))));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<StatusResposta>(
            future: futureEstabelecimentos,
            builder:
                (BuildContext context, AsyncSnapshot<StatusResposta> snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                atualizar();
                return shimmerLoader();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return shimmerLoader();
              } else {
                if (snapshot.hasData) {
                  return exibirEstabelecimentos(
                      snapshot.data?.retorno as List<Estabelecimento>);
                } else {
                  StatusResposta resposta = snapshot.error as StatusResposta;
                  if (resposta.codigo ==
                      StatusRespostaCodigo.ERRO_SEM_CONEXAO) {
                    return SemConexaoContainer(() {
                      setState(() {
                        atualizar();
                      });
                    });
                  } else {
                    return ErroAoCarregarContainer(() {
                      setState(() {
                        atualizar();
                      });
                    });
                  }
                }
              }
            }));
  }
}
