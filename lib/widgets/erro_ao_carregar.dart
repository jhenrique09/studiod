import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'erro_generico.dart';

Widget ErroAoCarregarContainer(VoidCallback callback) {
  return ErroGenerico(
      Icons.error,
      "Não foi possivel carregar a página devido a um erro do servidor.",
      callback);
}
