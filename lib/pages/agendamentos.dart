import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:studiod/models/agendamento.dart';
import 'package:studiod/services/agendamentos_service.dart';
import 'package:studiod/widgets/erro_ao_carregar.dart';
import 'package:studiod/widgets/shimmer_loader.dart';

import '../services/api/status_resposta.dart';
import '../widgets/erro_generico.dart';
import '../widgets/sem_conexao.dart';

class Agendamentos extends StatefulWidget {
  const Agendamentos({Key? key}) : super(key: key);

  @override
  State<Agendamentos> createState() => _AgendamentosState();
}

class _AgendamentosState extends State<Agendamentos> {
  Future<StatusResposta>? futureAgendamentos;
  Logger logger = Logger();

  Future<void> atualizar() async {
    Future.microtask(() => setState(() {
          futureAgendamentos = AgendamentosService().obterAgendamentos();
        }));
  }

  Widget exibirAgendamentos(List<Agendamento> agendamentos) {
    if (agendamentos.isEmpty) {
      return ErroGenerico(
          Icons.schedule, "Nenhum agendamento encontrado.", null);
    }
    return RefreshIndicator(
        onRefresh: atualizar,
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: agendamentos.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 6.0),
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: ListTile(
                              title: Text(
                                  agendamentos[index].estabelecimento.nome),
                              subtitle: Text(
                                  "${agendamentos[index].servicos.map((s) => s.nome).join(", ")}\n${agendamentos[index].data} - ${agendamentos[index].hora}")))));
            }));
  }

  Widget shimmerLoader() {
    return ShimmerLoader(const Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 6.0),
        child: Card(
            child: Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ListTile(title: Text(""), subtitle: Text(""))))));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<StatusResposta>(
            future: futureAgendamentos,
            builder:
                (BuildContext context, AsyncSnapshot<StatusResposta> snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                atualizar();
                return shimmerLoader();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return shimmerLoader();
              } else {
                if (snapshot.hasData) {
                  return exibirAgendamentos(
                      snapshot.data?.retorno as List<Agendamento>);
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
