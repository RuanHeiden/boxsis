
import 'package:boxsis/modelos/produto.dart';
import 'package:boxsis/services/firebase/deposito_firestore.dart';
import 'package:boxsis/services/firebase/produto_firestore.dart';
import 'package:flutter/cupertino.dart';

Future<List<Produto>> BuscaProdutoCadastrados(BuildContext context) async{
  var listaProduto = await getProduto(context);

  List<Produto> _produtos =[];
  for(int i = 0; i < listaProduto.length; i++){
    var produtoUnidade  = listaProduto[i];
    Produto produto = Produto(
      produtoUnidade['uid'] ?? '',
      produtoUnidade['nomeProduto'] ?? '',
      produtoUnidade['codigoRef'] ?? '',
      produtoUnidade['quantidade'] ?? '',
      produtoUnidade['grupo'] ?? '',
      produtoUnidade['marca'] ?? '',
      produtoUnidade['distribuidor'] ?? '',
      produtoUnidade['unidadeMedida'] ?? '',
      produtoUnidade['peso'] ?? '',
      produtoUnidade['dataValidade'] ?? '',
      produtoUnidade['dataEntrada'] ?? '',
      produtoUnidade['valorCompra'] ?? ''
    );
    _produtos.add(produto);
  }
  return _produtos;
}

