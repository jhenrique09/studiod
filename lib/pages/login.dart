import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:studiod/pages/alterar_senha.dart';
import 'package:studiod/pages/principal.dart';
import 'package:studiod/pages/recuperar_senha.dart';
import 'package:studiod/pages/registrar.dart';
import 'package:studiod/services/login_service.dart';
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
  Logger logger = Logger();
  Future<StatusResposta>? futureLogin;

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  void efetuarLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        futureLogin = LoginService()
            .validarLogin(emailController.text, senhaController.text);
      });
    }
  }

  Widget semConexaoContainer(
      BuildContext context, VoidCallback? acaoTentarNovamente) {
    return Container(
        child: Column(
      children: [
        const Icon(
          Icons.wifi_off,
          size: 32.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
        const Text(
          'Sem conexão com a internet',
          style: TextStyle(
            color: Color(0xff4c505b),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Center(
          child: Text(
              'Não foi possivel carregar a página pois não existe sinal de rede. Verifique sua conexão e tente novamente.',
              style: TextStyle(
                color: Color(0xff4c505b),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center),
        ),
        TextButton(
          onPressed: acaoTentarNovamente,
          child: Text("TENTAR NOVAMENTE"),
        )
      ],
    ));
  }

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
                onFieldSubmitted: (value) {
                  efetuarLogin();
                },
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
                enableInteractiveSelection: true,
                obscureText: true,
                onFieldSubmitted: (value) {
                  efetuarLogin();
                },
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
                      efetuarLogin();
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
    futureLogin ??= LoginService().validarLoginAtual();
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
                      if (snapshot.data?.codigo ==
                          StatusRespostaCodigo.AUTENTICADO_SENHA_PROVISORIA) {
                        Future.microtask(() {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "É necessário alterar a senha para acessar o aplicativo."),
                            duration: Duration(seconds: 4),
                          ));
                        });
                        Future.microtask(() => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    AlterarSenha(senhaTemporaria: true)),
                            (r) => false));
                      } else {
                        Future.microtask(() => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Principal()),
                            (r) => false));
                      }

                      return Loader();
                    } else if (snapshot.hasError) {
                      StatusResposta resposta =
                          snapshot.error as StatusResposta;

                      if (resposta.codigo ==
                              StatusRespostaCodigo.ERRO_SEM_CONEXAO &&
                          resposta.acao == Acao.LOGIN_JWT) {
                        return semConexaoContainer(context, () {
                          setState(() {
                            futureLogin = LoginService().validarLoginAtual();
                          });
                        });
                      }
                      senhaController.clear();
                      if (resposta.codigo !=
                          StatusRespostaCodigo.ERRO_TOKEN_NAO_DEFINIDO) {
                        Future.microtask(() => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                content: Text(resposta.mensagem),
                                duration: const Duration(seconds: 2))));
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
