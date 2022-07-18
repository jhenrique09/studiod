import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErroGenerico extends StatelessWidget {
  IconData icone;
  String mensagem;
  VoidCallback? atualizarCallback;

  ErroGenerico(this.icone, this.mensagem, this.atualizarCallback)
      : super(key: null);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icone,
          size: 32.0,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Center(
              child: Text(mensagem,
                  style: const TextStyle(
                    color: Color(0xff4c505b),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center),
            )),
        Visibility(
            visible: atualizarCallback != null,
            child: TextButton(
              onPressed: atualizarCallback,
              child: Text("ATUALIZAR"),
            ))
      ],
    ));
  }
}
