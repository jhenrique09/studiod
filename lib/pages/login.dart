import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiod/controllers/login_controller.dart';
import 'package:studiod/pages/principal.dart';
import 'package:studiod/pages/recuperar_senha.dart';
import 'package:studiod/pages/registrar.dart';
import 'package:studiod/utils/lower_case_text_formatter.dart';
import 'package:studiod/widgets/loader.dart';

import '../services/api/status_resposta.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  Future<StatusResposta>? futureLogin;

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  Widget loginContainer(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.topLeft,
        child: const Text(
          'Identifique-se para continuar',
          style: TextStyle(
            color: Color(0xff4c505b),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Container(
          padding: const EdgeInsets.only(top: 16),
          child: Form(
            key: _formKey,
            child: Column(children: [
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
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
                    return 'Por favor insira um email válido.';
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
                controller: senhaController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a senha';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const RecuperarSenha()));
                  },
                  child: const Text(
                    'Esqueceu a senha?',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      color: Color(0xff4c505b),
                    ),
                  ),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xff4c505b),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        futureLogin = context
                            .read<LoginController>()
                            .validarLogin(
                            emailController.text, senhaController.text);
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Registrar()));
                  },
                  child: const Text(
                    'Criar conta',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      color: Color(0xff4c505b),
                    ),
                  ),
                ),
              ]),
            ]),
          )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    futureLogin ??= context.read<LoginController>().validarLoginAtual();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 80),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/studiod.png",
                    width: 196,
                    height: 196,
                  )),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 35, right: 35, top: 96),
              child: FutureBuilder<StatusResposta>(
                future: futureLogin,
                builder: (BuildContext context,
                    AsyncSnapshot<StatusResposta> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loader();
                  } else {
                    if (snapshot.hasData) {
                      Future.microtask(() => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const Principal()),
                          (r) => false));
                      return Loader();
                    } else if (snapshot.hasError) {
                      if (snapshot.error is StatusResposta) {
                        StatusResposta resposta =
                            snapshot.error as StatusResposta;
                        if (resposta.codigo !=
                            StatusRespostaCodigo.TOKEN_NAO_DEFINIDO) {
                          Future.microtask(() => ScaffoldMessenger.of(context)
                              .showSnackBar(
                                  SnackBar(content: Text(resposta.mensagem))));
                        }
                      } else {
                        logger.e(snapshot.error);
                        Future.microtask(() => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text("Erro desconhecido"))));
                      }
                    }
                    return loginContainer(context);
                  }
                },
              ),
            ),
          ]),
        ));
  }
}
