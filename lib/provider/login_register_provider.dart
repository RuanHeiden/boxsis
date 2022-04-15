import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginRegisterProvider with ChangeNotifier{
  bool telaDeCadastro = false;

  void AbrirOuFecharTelaDeCadastro(){
    telaDeCadastro = !telaDeCadastro;
    notifyListeners();
  }
}