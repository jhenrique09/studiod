import 'package:flutter/material.dart';

class AlterarSenha extends StatefulWidget {
  const AlterarSenha({Key? key}) : super(key: key);

  @override
  _AlterarSenhaState createState() => _AlterarSenhaState();
}

class _AlterarSenhaState extends State<AlterarSenha> {
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
            title: Text("Alterar Senha"),
            elevation: 1,
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              padding: const EdgeInsets.all(36),
              child: Form(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 48, vertical: 12),
                        ),
                        icon: Icon(Icons.key),
                        label: const Text('Alterar senha'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO
                          }
                        },
                      ),
                    ]),
                  ])))
        ]),
      ),
    );
  }
}
