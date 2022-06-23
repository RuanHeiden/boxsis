import 'dart:js';

import 'package:boxsis/modelos/deposito.dart';
import 'package:boxsis/services/depositos_cadastrado.dart';
import 'package:flutter/material.dart';

class DepositoProvider with ChangeNotifier{
  List<Deposito> depositos = [];
  String depositoSelecionado = '';
  String textFiltroDiretoDeposito = '';

  Future<void> AtualizaListaDeDepositosProvider(BuildContext context) async{
    depositos = await BuscaDepositoCadastrado(context);
    notifyListeners();
  }

  limpaListaDeDepositoProvider() {
    //depositos.clear(); //Limpa lista de empresas
    depositos = [];
    depositoSelecionado = '';
    textFiltroDiretoDeposito = '';

    notifyListeners();
  }

  selecionadaDeposito(String deposito ){
    depositoSelecionado = deposito;
    notifyListeners();
  }


  ///Filtro
  limpaDepositoSelecionada(){
    selecionadaDeposito('');
    limpaListaDeDepositoProvider();
    notifyListeners();
  }

  filtrandoDireto(value){
    textFiltroDiretoDeposito = value;
    notifyListeners();
  }

}