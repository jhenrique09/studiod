import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:studiod/pages/login.dart';
import 'package:studiod/utils/lower_case_text_formatter.dart';

import '../controllers/recuperar_senha_controller.dart';
import '../services/api/status_resposta.dart';
import '../widgets/loader.dart';

class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({Key? key}) : super(key: key);

  @override
  State<RecuperarSenha> createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  Future<StatusResposta>? futureRecuperarSenha;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget RecuperarSenhaContainer(BuildContext context) {
    return Column(children: [
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
          if (value == null ||
              value.isEmpty ||
              !EmailValidator.validate(value)) {
            return 'Por favor insira um email válido.';
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
              if (_formKey.currentState!.validate()) {
                futureRecuperarSenha = RecuperarSenhaController()
                    .recuperarSenha(emailController.text);
                setState(() {});
              }
            },
            icon: const Icon(Icons.arrow_forward),
          ),
        ),
      ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(
            futureRecuperarSenha == null);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (futureRecuperarSenha == null) {
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
                "Recuperar\nSenha",
                style: TextStyle(color: Color(0xff4c505b), fontSize: 33),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(36),
                child: Form(
                  key: _formKey,
                  child: FutureBuilder<StatusResposta>(
                    future: futureRecuperarSenha,
                    builder: (BuildContext context,
                        AsyncSnapshot<StatusResposta> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Loader();
                      } else {
                        if (snapshot.hasData) {
                          Future.microtask(() =>
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Login()),
                                (r) => false)
                          );
                          Future.microtask(() => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "Senha provisória enviada para o email cadastrado."),
                                duration: Duration(seconds: 2),
                              )));
                          return Loader();
                        } else if (snapshot.hasError) {
                          StatusResposta resposta =
                              snapshot.error as StatusResposta;
                          Future.microtask(() => ScaffoldMessenger.of(context)
                              .showSnackBar(
                                  SnackBar(content: Text(resposta.mensagem))));
                        }
                        futureRecuperarSenha = null;
                        return RecuperarSenhaContainer(context);
                      }
                    },
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
