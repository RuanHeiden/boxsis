import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/services/busca_empresas_cadastrada.dart';
import 'package:flutter/material.dart';

class HomeProvicer with ChangeNotifier {
  List<Empresa> empresas = [];

  Future<void> AtualizaListaDeEmpresasProvider() async {
    empresas = await BuscaEmpresaCadastrada();
    notifyListeners();
  }

  deslogaUsuarioProvider() {
    empresas.clear(); //Limpa lista de empresas
    notifyListeners();
  }
}
