import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:provider/provider.dart';
import 'package:studiod/controllers/login_controller.dart';
import 'package:studiod/controllers/recuperar_senha_controller.dart';
import 'package:studiod/controllers/registrar_controller.dart';
import 'package:studiod/services/api/api_service.dart';

import 'pages/login.dart';

GetIt sl = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  sl.registerLazySingleton(() => ApiService(Dio()));

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => RegistrarController()),
        ChangeNotifierProvider(create: (_) => RecuperarSenhaController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch:
                generateMaterialColor(color: const Color(0xffd81b60))),
        home: const Login(),
      )));
}
