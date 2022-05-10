import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/services/busca_empresas_cadastrada.dart';
import 'package:flutter/material.dart';

class HomeProvicer with ChangeNotifier{
  List<Empresa> Empresas = [];

  Future<void> AtualizaListaDeEmpresasProvider() async {
    Empresas = await BuscaEmpresaCadastrada();
    notifyListeners();
  }

  deslogaUsuarioProvider(){
    //Empresas.clear();//Limpa lista de empresas
   // notifyListeners();
  }

}