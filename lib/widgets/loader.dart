import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  String? mensagem;

  Loader({Key? key, this.mensagem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const SpinKitRipple(color: Colors.pink, size: 96.0),
          Text(
            mensagem ?? 'Aguarde...',
            style: const TextStyle(
              color: Color(0xff4c505b),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ]));
  }
}
