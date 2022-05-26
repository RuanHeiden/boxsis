import 'package:boxsis/services/produto_cadastrado.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../modelos/produto.dart';

class ProdutoProvider with ChangeNotifier{
  List<Produto> produtos = [];
  String produtoSelecionado = '';
  String textFieldDiretoProduto = '';
  String unidadeMedidaProduto = 'Unidade medida';

  Future<void> AtualizaListaDeProdutosProvider(BuildContext context) async{
    produtos = await BuscaProdutoCadastrados(context);
    notifyListeners();
  }

  limpaListaProdutoProvider(){
    produtos.clear();
    notifyListeners();
  }

  selecionadaProduto(String deposito){
    produtoSelecionado = deposito;
    notifyListeners();
  }

  alteraUnidadeMedida(String valor){
    unidadeMedidaProduto = valor;
    notifyListeners();
  }

  filtrandoDireto(value){
    textFieldDiretoProduto = value;
    notifyListeners();
  }
}