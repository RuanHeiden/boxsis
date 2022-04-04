import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginRegisterProvider with ChangeNotifier{
  bool telaDeCadastro = false;

  void AbrirOuFecharTelaDeCadastro(){
    print('telaDeCadastro $telaDeCadastro');
    telaDeCadastro = !telaDeCadastro;
    notifyListeners();
  }


}