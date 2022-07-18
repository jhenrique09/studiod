import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:studiod/models/estabelecimento.dart';
import 'package:studiod/models/horarios_disponiveis_agendamento.dart';
import 'package:studiod/pages/pagina_interna.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/agendamentos_service.dart';
import '../services/api/status_resposta.dart';
import '../widgets/erro_ao_carregar.dart';
import '../widgets/erro_generico.dart';
import '../widgets/loader.dart';
import '../widgets/sem_conexao.dart';

class Agendamento extends StatefulWidget {
  Estabelecimento estabelecimento;
  VoidCallback callbackEstabelecimento;

  Agendamento(
      {Key? key,
      required this.estabelecimento,
      required this.callbackEstabelecimento})
      : super(key: key);

  @override
  State<Agendamento> createState() => _AgendamentoState();
}

class _AgendamentoState extends PaginaInternaState<Agendamento> {
  Logger logger = Logger();
  Future<StatusResposta>? futureAgendamento;
  List<HorariosDisponiveisAgendamento> horariosDisponiveis = [];
  String? dataSelecionada;
  String? horaSelecionada;
  List<dynamic> servicosSelecionados = [];
  bool obterHorarios = false;
  bool forcarExibirForm = false;
  final _servicosKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> _horaDropdownKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _dataDropdownKey =
      GlobalKey<FormFieldState>();

  final _formKey = GlobalKey<FormState>();

  Widget detalhesEstabelecimento() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(widget.estabelecimento.url_imagem)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.estabelecimento.nome,
                  style: const TextStyle(
                    color: Color(0xff4c505b),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ))),
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.estabelecimento.obterEnderecoCompleto(),
              style: const TextStyle(
                color: Color(0xff4c505b),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(8),
            child: InkWell(
                onTap: () async {
                  Uri uri =
                      Uri(scheme: 'tel', path: widget.estabelecimento.telefone);
                  canLaunchUrl(uri).then((bool result) {
                    if (result) {
                      launchUrl(uri);
                    }
                  });
                },
                child: Text(
                  widget.estabelecimento.obterTelefoneFormatado(),
                  style: const TextStyle(
                    color: Color(0xff4c505b),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
    );
  }

  Widget formAgendamento(BuildContext context) {
    if (horariosDisponiveis.isEmpty) {
      return ErroGenerico(Icons.schedule,
          "Não existem horários disponiveis para agendamento.", null);
    }
    return Form(
        key: _formKey,
        child: Column(children: [
          MultiSelectBottomSheetField(
              key: _servicosKey,
              onConfirm: (results) {
                servicosSelecionados = results;
              },
              searchable: true,
              initialChildSize: 0.7,
              maxChildSize: 0.95,
              confirmText: Text("Salvar"),
              cancelText: Text("Cancelar"),
              buttonIcon: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey.shade700,
              ),
              title: const Text("Escolher Serviços",
                  style: TextStyle(fontSize: 14)),
              buttonText: Text("Serviços",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700)),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.8),
                borderRadius: BorderRadius.circular(10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Selecione um serviço.';
                }
                return null;
              },
              listType: MultiSelectListType.CHIP,
              chipDisplay: MultiSelectChipDisplay(
                onTap: (s) {
                  setState(() {
                    forcarExibirForm = true;
                    servicosSelecionados.remove(s);
                  });
                },
              ),
              items: widget.estabelecimento.servicos
                  .map(
                    (s) => MultiSelectItem<String>(s.id.toString(), s.nome),
                  )
                  .toList()),
          const SizedBox(
            height: 30,
          ),
          DropdownButtonFormField(
              onChanged: (val) {
                setState(() {
                  horaSelecionada = null;
                  dataSelecionada = val.toString();
                  _horaDropdownKey.currentState?.reset();
                  forcarExibirForm = true;
                });
              },
              key: _dataDropdownKey,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: 'Data do serviço',
                hintStyle: const TextStyle(fontSize: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Selecione uma data.';
                }
                return null;
              },
              items: horariosDisponiveis
                  .map((h) => DropdownMenuItem<String>(
                        value: h.data,
                        child: Text(h.data),
                      ))
                  .toList()),
          if (dataSelecionada != null &&
              horariosDisponiveis
                  .where((h) => h.data == dataSelecionada)
                  .isNotEmpty) ...[
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField(
                onChanged: (val) {
                  horaSelecionada = val.toString();
                },
                key: _horaDropdownKey,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: 'Hora do serviço',
                  hintStyle: const TextStyle(fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um horário.';
                  }
                  return null;
                },
                items: horariosDisponiveis
                    .where((h) => h.data == dataSelecionada)
                    .first
                    .horarios
                    .map((h) => DropdownMenuItem<String>(
                          value: h,
                          child: Text(h),
                        ))
                    .toList()),
          ],
          const SizedBox(
            height: 30,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
              ),
              icon: const Icon(Icons.calendar_today),
              label: const Text('Agendar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    futureAgendamento = AgendamentosService().criarAgendamento(
                        widget.estabelecimento.id,
                        dataSelecionada!,
                        horaSelecionada!,
                        servicosSelecionados.map((e) => int.parse(e)).toList());
                  });
                }
              },
            ),
          ]),
        ]));
  }

  Future<void> atualizarHorarios() async {
    obterHorarios = true;
    Future.microtask(() => setState(() {
          futureAgendamento = AgendamentosService()
              .obterHorariosDisponiveis(widget.estabelecimento.id);
        }));
  }

  Widget exibirLoader() {
    return Loader(mensagem: obterHorarios ? "Atualizando horários..." : null);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(futureAgendamento == null);
        },
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: AppBar(
                leading: IconButton(
                    onPressed: () {
                      if (futureAgendamento == null) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.arrow_back)),
                title: const Text("Agendamento"),
                elevation: 1,
              )),
          body: SingleChildScrollView(
            child: Column(children: [
              detalhesEstabelecimento(),
              Padding(
                  padding: const EdgeInsets.all(36),
                  child: FutureBuilder<StatusResposta>(
                      future: futureAgendamento,
                      builder: (BuildContext context,
                          AsyncSnapshot<StatusResposta> snapshot) {
                        if (forcarExibirForm) {
                          forcarExibirForm = false;
                          return formAgendamento(context);
                        } else if (snapshot.connectionState ==
                            ConnectionState.none) {
                          if (widget.estabelecimento.servicos.isEmpty) {
                            return ErroGenerico(
                                Icons.error,
                                "Este estabelecimento ainda não possui serviços cadastrados.",
                                null);
                          } else {
                            atualizarHorarios();
                            return exibirLoader();
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return exibirLoader();
                        } else {
                          futureAgendamento = null;
                          obterHorarios = false;
                          if (snapshot.hasData) {
                            if (snapshot.data?.acao == Acao.OBTER_HORARIOS) {
                              horariosDisponiveis = snapshot.data?.retorno
                                  as List<HorariosDisponiveisAgendamento>;
                              return formAgendamento(context);
                            } else {
                              Future.microtask(() {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("Agendamento criado com sucesso."),
                                ));
                                widget.callbackEstabelecimento.call();
                              });
                              return Loader();
                            }
                          } else {
                            StatusResposta resposta =
                                snapshot.error as StatusResposta;
                            if (resposta.acao == Acao.OBTER_HORARIOS) {
                              if (resposta.codigo ==
                                  StatusRespostaCodigo.ERRO_SEM_CONEXAO) {
                                return SemConexaoContainer(() {
                                  setState(() {
                                    atualizarHorarios();
                                  });
                                });
                              } else {
                                return ErroAoCarregarContainer(() {
                                  setState(() {
                                    atualizarHorarios();
                                  });
                                });
                              }
                            } else {
                              _dataDropdownKey.currentState?.reset();
                              _horaDropdownKey.currentState?.reset();
                              if (resposta.codigo ==
                                  StatusRespostaCodigo.ERRO_SEM_CONEXAO) {
                                Future.microtask(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(resposta.mensagem)));
                                });
                                return formAgendamento(context);
                              }
                              Future.microtask(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(resposta.mensagem)));
                                setState(() {
                                  atualizarHorarios();
                                });
                              });
                              return Loader();
                            }
                          }
                        }
                      }))
            ]),
          ),
        ));
  }
}
