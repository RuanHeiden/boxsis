import 'package:boxsis/modelos/usuario.dart';
import 'package:boxsis/services/produto_cadastrado.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../modelos/produto.dart';

class UsuarioProvider with ChangeNotifier{
  String idUsuario = '';
  String nome = '';
  String email = '';
  String idade = '';
  List<String>? empresas = [];

  Future<void> gravaUsuarioProvider(Usuario usuario) async{
    nome = usuario.nome;
    email = usuario.email;
    idade = usuario.idade;
    notifyListeners();
  }

}