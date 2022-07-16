import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:studiod/services/api/api_service.dart';
import 'package:studiod/utils/utils.dart';

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

  sl.registerLazySingleton(() => ApiService(Dio(BaseOptions(
    baseUrl: getApiBaseUrl()
  ))));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    supportedLocales: const [
      Locale('pt', ''),
    ],
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
    ],
    theme: ThemeData(
        useMaterial3: true,
        primarySwatch: generateMaterialColor(color: const Color(0xffd81b60))),
    home: const Login(),
  ));
}
