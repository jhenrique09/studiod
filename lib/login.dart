import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:studiod/utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                child: Column(children: [
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
                                return 'Informe a senha.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'registrar');
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
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.pushReplacementNamed(
                                            context, 'principal');
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ]),
                        ]),
                      )),
                ])),
          ]),
        ));
  }
}
