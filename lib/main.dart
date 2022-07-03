import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:studiod/principal.dart';

import 'agendamento.dart';
import 'alterar_senha.dart';
import 'login.dart';
import 'meus_dados.dart';
import 'registrar.dart';
import 'saloes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        theme: ThemeData(
            primarySwatch:
                generateMaterialColor(color: const Color(0xffd81b60))),
        routes: {
          'login': (context) => const Login(),
          'registrar': (context) => const Registrar(),
          'principal': (context) => const Principal(),
          'saloes': (context) => const Saloes(),
          'meus_dados': (context) => const MeusDados(),
          'agendamento': (context) => const Agendamento(),
          'alterar_senha': (context) => const AlterarSenha(),
        }),
  );
}
