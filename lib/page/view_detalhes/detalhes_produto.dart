import 'package:boxsis/mask/mask.dart';
import 'package:boxsis/modelos/deposito.dart';
import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/modelos/produto.dart';
import 'package:boxsis/page/view-cadastros/cadastra_deposito.dart';
import 'package:boxsis/provider/deposito_provider.dart';
import 'package:boxsis/provider/home_empresa.dart';
import 'package:boxsis/provider/produto_provider.dart';
import 'package:boxsis/services/firebase/deposito_firestore.dart';
import 'package:boxsis/services/firebase/empresa_firestore.dart';
import 'package:boxsis/services/firebase/produto_firestore.dart';
import 'package:boxsis/view/button/button_average_title_icon_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../view/my_textfield.dart';

ModalDetalhesDoProduto(BuildContext context, Produto produto) {
  final _formKeyCadastraProduto = GlobalKey<FormState>();

  final _nomeProdutoController = TextEditingController(text: produto.nomeProduto);
  final _codigoRefController = TextEditingController( text: produto.codigoRef);
  final _quantidadeController = TextEditingController( text: produto.quantidade);
  final _grupoController = TextEditingController( text: produto.grupo);
  final _marcaController = TextEditingController( text: produto.marca);
  final _distribuidorController = TextEditingController( text: produto.distribuidor);

  Provider.of<ProdutoProvider>(context, listen: false).alteraUnidadeMedida(produto.unidadeMedida);
  final _pesoController = TextEditingController( text: produto.peso);
  final _dataValidadeController = TextEditingController( text: produto.dataValidade);
  final _dataEntradaController = TextEditingController( text: produto.dataEntrada);
  final _valorCompraController = TextEditingController( text: produto.valorCompra);


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            width: 600,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Form(
                    key: _formKeyCadastraProduto,
                    child: SingleChildScrollView(
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25, bottom: 40, left: 40, right: 40),
                              child: Text(
                                'Detalhes do deposito ${produto.nomeProduto}',
                                style: TextStyle(color: Colors.black54, fontSize: 23),
                              ),
                            ),
                          ),
                          TextFieldCadastro('Nome', _nomeProdutoController, TextInputType.text, true),
                          TextFieldCadastro('Codigo Ref', _codigoRefController, TextInputType.text, true),
                          TextFieldCadastro('Quantidade', _quantidadeController, TextInputType.text, false),
                          TextFieldCadastro('Grupo', _grupoController, TextInputType.text, false),
                          TextFieldCadastro('Marca', _marcaController, TextInputType.text, false),
                          TextFieldCadastro('Distribuidor', _distribuidorController, TextInputType.text, false), Container(
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                            child: DropdownButton(

                              itemHeight: 50,
                              items:  [
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 470,child: const Text('Unidade medida', style: TextStyle(color: Colors.black54 ),),),value: 'Unidade medida',),
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 250,child: Text('Metro'),),value: 'Metro',),
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 250,child: Text('Unidade'),),value: 'Unidade',),
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 250,child: Text('Quilogram'),),value: 'Quilogram',),
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 250,child: Text('Litro'),),value: 'Litro',),
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 250,child: Text('Caixa'),),value: 'Caixa',),
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 250,child: Text('Mililitro'),),value: 'Mililitro',),
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 250,child: Text('Peça'),),value: 'Peça',),
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 250,child: Text('Fardo'),),value: 'Fardo',),
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 250,child: Text('Pacote'),),value: 'Pacote',),
                                DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 250,child: Text('Grama'),),value: 'Grama',),
                              ],
                              value: context.watch<ProdutoProvider>().unidadeMedidaProduto,
                              onChanged: ( newValue) {
                                Provider.of<ProdutoProvider>(context, listen: false).alteraUnidadeMedida(newValue.toString());
                              },
                            ),
                          ),
                          TextFieldCadastro('Peso', _pesoController, TextInputType.text, false),
                          TextFieldCadastro('Data Validade', _dataValidadeController, TextInputType.text, false, mask: maskData),
                          TextFieldCadastro('Data Entrada', _dataEntradaController, TextInputType.text, false, mask: maskData),
                          TextFieldCadastro('Valor de Compra', _valorCompraController, TextInputType.text, false),

                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    width: 140,
                                    height: 40,
                                    child: InkWell(
                                      onTap: () async {
                                        if (_formKeyCadastraProduto.currentState!.validate()) {
                                          await DeletaProduto(context, produto);
                                          Provider.of<ProdutoProvider>(context,listen: false).AtualizaListaDeProdutosProvider(context);
                                          Navigator.pop(context);
                                        } else {
                                          ///TRATAR
                                        }
                                      },
                                      child: buttonAverageTitleIconColor(
                                        name: 'Excluir ',
                                        iconDoButton: Icons.clear,
                                        corDoTexto: Colors.white,
                                        corDoIcon: Colors.white,
                                        corDoBotao: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 40,
                                    child: InkWell(
                                      onTap: () {
                                        if (_formKeyCadastraProduto.currentState!.validate()) {
                                          CadastraProduto(
                                            context,
                                            _nomeProdutoController.text,
                                            _codigoRefController.text,
                                            _quantidadeController.text,
                                            _grupoController.text,
                                            _marcaController.text,
                                            _distribuidorController.text,
                                            Provider.of<ProdutoProvider>(context,listen: false).unidadeMedidaProduto,
                                            _pesoController.text,
                                            _dataValidadeController.text,
                                            _dataEntradaController.text,
                                            _valorCompraController.text,
                                            produto.uid.toString() ,
                                          );

                                          Provider.of<ProdutoProvider>(context,listen: false).AtualizaListaDeProdutosProvider(context);
                                        } else {
                                          ///TRATAR
                                        }
                                      },
                                      child: buttonAverageTitleIconColor(
                                        name: 'Editar ',
                                        iconDoButton: Icons.edit,
                                        corDoTexto: Colors.white,
                                        corDoIcon: Colors.white,
                                        corDoBotao: Colors.blue,
                                      ),
                                    ),
                                  ),

                                ],
                              )
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    )
                  ),
                ),
              ],
            ),
          )
      );
    },
  );
}

///Pegando os dados informados pelo usuario e montando o objeto empresa para iniciar o cadastro
CadastraProduto(
    BuildContext context,
     String nomeProduto,
     String codigoRef,
     String quantidade,
     String grupo,
     String marca,
     String distribuidor,
     String unidadeMedida,
     String peso,
     String dataValidade,
     String dataEntrada,
     String valor,
     String oldUID,
    ) async {

  //
  // final timeTicksNow = DateTime.now().millisecondsSinceEpoch;
  // String timeUID = timeTicksNow.toString();

  Produto produto = Produto(
    oldUID,
     nomeProduto,
     codigoRef,
     quantidade,
     grupo,
     marca,
     distribuidor,
     unidadeMedida,
     peso,
     dataValidade,
     dataEntrada,
     valor,
  );


  await gravaProduto(context, produto, oldUID).then((value){
    if(value){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deposito cadastrado com sucesso !')),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe os dados corretamente para efetuar o cadastro da deposito !')),
      );
    }
    //value == true ? Navigator.pop(context) : null;
  });
}


