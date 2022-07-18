import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SemConexaoContainer extends StatelessWidget {
  VoidCallback acaoTentarNovamente;

  SemConexaoContainer(this.acaoTentarNovamente);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.wifi_off,
          size: 32.0,
        ),
        const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Sem conexão com a internet',
              style: TextStyle(
                color: Color(0xff4c505b),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            )),
        const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Center(
              child: Text(
                  'Não foi possivel carregar a página pois não existe sinal de rede. Verifique sua conexão e tente novamente.',
                  style: TextStyle(
                    color: Color(0xff4c505b),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center),
            )),
        TextButton(
          onPressed: acaoTentarNovamente,
          child: Text("TENTAR NOVAMENTE"),
        )
      ],
    ));
  }
}
