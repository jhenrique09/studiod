import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_generator/material_color_generator.dart';

import 'pages/login.dart';

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

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        useMaterial3: true,
        primarySwatch: generateMaterialColor(color: const Color(0xffd81b60))),
    home: const Login(),
  ));
}
