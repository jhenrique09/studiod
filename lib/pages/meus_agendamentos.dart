import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:studiod/models/agendamento.dart';
import 'package:studiod/services/meus_agendamentos_service.dart';
import 'package:studiod/widgets/erro_ao_carregar.dart';

import '../services/api/status_resposta.dart';
import '../widgets/loader.dart';
import '../widgets/sem_conexao.dart';

class MeusAgendamentos extends StatefulWidget {
  const MeusAgendamentos({Key? key}) : super(key: key);

  @override
  State<MeusAgendamentos> createState() => _MeusAgendamentosState();
}

class _MeusAgendamentosState extends State<MeusAgendamentos> {
  Future<StatusResposta>? futureMeusAgendamentos;
  Logger logger = Logger();

  Future<void> atualizar() async {
    Future.microtask(() => setState(() {
          futureMeusAgendamentos =
              MeusAgendamentosService().obterMeusAgendamentos();
        }));
  }

  Widget exibirAgendamentos(List<Agendamento> agendamentos) {
    return RefreshIndicator(
        onRefresh: atualizar,
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: agendamentos.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatusResposta>(
        future: futureMeusAgendamentos,
        builder:
            (BuildContext context, AsyncSnapshot<StatusResposta> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            atualizar();
            return Loader();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          } else {
            if (snapshot.hasData) {
              return exibirAgendamentos(
                  snapshot.data?.retorno as List<Agendamento>);
            } else {
              StatusResposta resposta = snapshot.error as StatusResposta;
              if (resposta.codigo == StatusRespostaCodigo.ERRO_SEM_CONEXAO) {
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
        });
  }
}
