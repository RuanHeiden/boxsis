import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginRegisterProvider with ChangeNotifier{
  bool telaDeCadastro = false;
  bool loadding = false;

  void AbrirOuFecharTelaDeCadastro(){
    telaDeCadastro = !telaDeCadastro;
    notifyListeners();
  }

  void TelaLoadding(bool tipo){
    loadding = tipo;
    print(tipo);
    notifyListeners();
  }

}