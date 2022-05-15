import 'dart:js';

import 'package:boxsis/modelos/deposito.dart';
import 'package:boxsis/services/depositos_cadastrado.dart';
import 'package:flutter/material.dart';

class DepositoProvider with ChangeNotifier{
  List<Deposito> depositos = [];
  String depositoSelecionado = '';

  Future<void> AtualizaListaDeDepositosProvider(BuildContext context) async{
    depositos = await BuscaDepositoCadastrado(context);
    notifyListeners();
  }

}