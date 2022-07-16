import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:studiod/services/registrar_usuario_service.dart';
import 'package:studiod/pages/principal.dart';
import 'package:studiod/utils/lower_case_text_formatter.dart';

import '../services/api/status_resposta.dart';
import '../widgets/loader.dart';

class Registrar extends StatefulWidget {
  const Registrar({Key? key}) : super(key: key);

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  Future<StatusResposta>? futureRegistrar;
  final _formKey = GlobalKey<FormState>();
  late FocusNode senhaFocus;
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    senhaFocus = FocusNode();
  }

  Widget registrarContainer(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            textCapitalization: TextCapitalization.words,
            autocorrect: false,
            enableSuggestions: false,
            onFieldSubmitted: (value) {
              registrar();
            },
            decoration: InputDecoration(
              fillColor: Colors.grey.shade100,
              filled: true,
              hintText: 'Nome Completo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
        ),
        controller: nomeController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor insira seu nome.';
          }
          return null;
        },
      ),
      const SizedBox(
        height: 30,
      ),
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        inputFormatters: [LowerCaseTextFormatter()],
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onFieldSubmitted: (value) {
          registrar();
        },
        controller: emailController,
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              !EmailValidator.validate(value)) {
            return 'Por favor insira um email válido.';
          }
          return null;
        },
      ),
      const SizedBox(
        height: 30,
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          LowerCaseTextFormatter(),
          MaskTextInputFormatter(mask: "(##) #####-####")
        ],
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: 'Celular p/ contato',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onFieldSubmitted: (value) {
          registrar();
        },
        controller: celularController,
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              value.replaceAll(RegExp(r'\D'), '').length != 11) {
            return 'Por favor insira um celular válido.';
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
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: 'Senha',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onFieldSubmitted: (value) {
          registrar();
        },
        controller: senhaController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Informe uma senha.';
          } else if (value.length < 6) {
            return 'A senha deve conter no mínimo 6 caracteres.';
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
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: 'Confirmar Senha',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onFieldSubmitted: (value) {
          registrar();
        },
        controller: confirmarSenhaController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Confirme a senha.';
          } else if (senhaController.text != confirmarSenhaController.text) {
            senhaController.clear();
            confirmarSenhaController.clear();
            senhaFocus.requestFocus();
            return 'As senhas não correspondem.';
          }
          return null;
        },
      ),
      const SizedBox(
        height: 40,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color(0xff4c505b),
          child: IconButton(
            color: Colors.white,
            onPressed: () {
              registrar();
                },
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
          ]),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(
            futureRegistrar == null);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (futureRegistrar == null) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xff4c505b)),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 35, top: 80),
              child: const Text(
                "Criar\nConta",
                style: TextStyle(color: Color(0xff4c505b), fontSize: 33),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(36),
              child: FutureBuilder<StatusResposta>(
                future: futureRegistrar,
                builder: (BuildContext context,
                    AsyncSnapshot<StatusResposta> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loader();
                  } else {
                    if (snapshot.hasData) {
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                    builder: (_) => const Principal()),
                                (r) => false);
                          });
                          Future.microtask(() => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "Usuário registrado com sucesso, autenticando..."),
                                duration: Duration(seconds: 2),
                              )));
                          return Loader();
                        } else if (snapshot.hasError) {
                      StatusResposta resposta =
                          snapshot.error as StatusResposta;
                      Future.microtask(() => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                              content: Text(resposta.mensagem),
                              duration: const Duration(seconds: 2))));
                    }
                    futureRegistrar = null;
                    return registrarContainer(context);
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void registrar() {
    if (_formKey.currentState!.validate()) {
      futureRegistrar = RegistrarUsuarioService().registrar(
          nomeController.text,
          emailController.text,
          senhaController.text,
          celularController.text.replaceAll(RegExp(r"\D"), ""));
      setState(() {});
    }
  }
}
