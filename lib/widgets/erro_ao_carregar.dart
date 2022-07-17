import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErroAoCarregarContainer extends StatelessWidget {
  VoidCallback acaoTentarNovamente;

  ErroAoCarregarContainer(this.acaoTentarNovamente);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          size: 32.0,
        ),
        const Text(
          'Erro ao carregar',
          style: TextStyle(
            color: Color(0xff4c505b),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Center(
          child: Text(
              'Não foi possivel carregar a página devido a um erro do servidor.',
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
}
