import 'package:flutter/material.dart';

import '../services/alterar_senha_service.dart';
import '../services/api/status_resposta.dart';
import '../widgets/loader.dart';
import 'pagina_interna.dart';

class AlterarSenha extends StatefulWidget {
  const AlterarSenha({Key? key}) : super(key: key);

  @override
  State<AlterarSenha> createState() => _AlterarSenhaState();
}

class _AlterarSenhaState extends PaginaInternaState<AlterarSenha> {
  Future<StatusResposta>? futureAlterarSenha;
  final _formKey = GlobalKey<FormState>();

  late FocusNode novaSenhaFocus;
  TextEditingController senhaController = TextEditingController();
  TextEditingController novaSenhaController = TextEditingController();
  TextEditingController confirmarNovaSenhaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    novaSenhaFocus = FocusNode();
  }

  Widget alterarSenhaContainer(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Senha atual',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            controller: senhaController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe a senha atual.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            obscureText: true,
            focusNode: novaSenhaFocus,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Nova senha',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            controller: novaSenhaController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe a nova senha.';
              } else if (value.length < 6) {
                return 'A nova senha deve conter no mínimo 6 caracteres.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Confirmar nova senha',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            controller: confirmarNovaSenhaController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirme a nova senha.';
              } else if (novaSenhaController.text !=
                  confirmarNovaSenhaController.text) {
                novaSenhaController.clear();
                confirmarNovaSenhaController.clear();
                novaSenhaFocus.requestFocus();
                return 'As senhas não correspondem.';
              }
              return null;
            },
          ),
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
              icon: const Icon(Icons.key),
              label: const Text('Alterar senha'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  futureAlterarSenha = AlterarSenhaService().atualizarSenha(
                      senhaController.text, novaSenhaController.text);
                  setState(() {});
                }
              },
            ),
          ]),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text("Alterar Senha"),
            elevation: 1,
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              padding: const EdgeInsets.all(36),
              child: FutureBuilder<StatusResposta>(
                future: futureAlterarSenha,
                builder: (BuildContext context,
                    AsyncSnapshot<StatusResposta> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loader();
                  } else {
                    if (snapshot.hasData) {
                      Future.microtask(() => Navigator.of(context).pop());
                      Future.microtask(() => ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Senha atualizada com sucesso."),
                            duration: Duration(seconds: 2),
                          )));
                      return Loader();
                    } else if (snapshot.hasError) {
                      StatusResposta resposta =
                          snapshot.error as StatusResposta;
                      handleStatusResposta(context, resposta).then((value) {
                        Future.microtask(() => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                content: Text(resposta.mensagem),
                                duration: const Duration(seconds: 2))));
                      });
                    }
                    futureAlterarSenha = null;
                    return alterarSenhaContainer(context);
                  }
                },
              ))
        ]),
      ),
    );
  }
}
