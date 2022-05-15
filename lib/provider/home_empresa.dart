import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/services/empresas_cadastrada.dart';
import 'package:flutter/material.dart';

class HomeProvicer with ChangeNotifier {
  List<Empresa> empresas = [];
  String empresaSelecionada = '';

  Future<void> AtualizaListaDeEmpresasProvider() async {
    empresas = await BuscaEmpresaCadastrada();
    notifyListeners();
  }

  deslogaUsuarioProvider() {
    empresas.clear(); //Limpa lista de empresas
    notifyListeners();
  }

  selecionadaEmpresa(String empresa ){
    empresaSelecionada = empresa;
    notifyListeners();
  }

  limpaEmpresaSelecionada(){
    selecionadaEmpresa('');
    notifyListeners();
  }
}
