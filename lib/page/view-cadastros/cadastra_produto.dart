import 'package:boxsis/mask/mask.dart';
import 'package:boxsis/modelos/produto.dart';
import 'package:boxsis/provider/deposito_provider.dart';
import 'package:boxsis/provider/produto_provider.dart';
import 'package:boxsis/view/button/button_average_title_icon_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../services/firebase/produto_firestore.dart';
import '../../view/my_textfield.dart';

ModalCadastraProduto(BuildContext context) {
  final _formKeyCadastraProduto = GlobalKey<FormState>();
  final _nomeProdutoController = TextEditingController();
  final _codigoRefController = TextEditingController();

  final _quantidadeController = TextEditingController();
  final _grupoController = TextEditingController();
  final _marcaController = TextEditingController();
  final _distribuidorController = TextEditingController();
  //final _unidadeMedidaController = TextEditingController();
  final _pesoController = TextEditingController();
  final _dataValidadeController = TextEditingController();
  final _dataEntradaController = TextEditingController();
  final _valorCompraController = TextEditingController();


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Form(
                  key: _formKeyCadastraProduto,
                  child: SingleChildScrollView(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 40),
                            child: Text(
                              'Cadastre seu Produto',
                              style: TextStyle(color: Colors.black54, fontSize: 23),
                            ),
                          ),
                        ),
                        TextFieldCadastro('Nome', _nomeProdutoController, TextInputType.text, true),
                        TextFieldCadastro('Codigo Ref', _codigoRefController, TextInputType.text, true),
                        TextFieldCadastro('Quantidade', _quantidadeController, TextInputType.text, false),
                        TextFieldCadastro('Grupo', _grupoController, TextInputType.text, false),
                        TextFieldCadastro('Marca', _marcaController, TextInputType.text, false),
                        TextFieldCadastro('Distribuidor', _distribuidorController, TextInputType.text, false),

                        //TextFieldCadastro('Unidade Medida', _unidadeMedidaController, TextInputType.text, false),

                        ///    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          child: DropdownButton(

                            itemHeight: 50,
                            items:  [
                              DropdownMenuItem(child: Container( padding: EdgeInsets.symmetric(horizontal: 5), width: 400,child: const Text('Unidade medida', style: TextStyle(color: Colors.black54 ),),),value: 'Unidade medida',),
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


                        TextFieldCadastro(context.watch<ProdutoProvider>().unidadeMedidaProduto, _pesoController, TextInputType.text, false),
                        TextFieldCadastro('Data Validade', _dataValidadeController, TextInputType.text, false, mask: maskData),
                        TextFieldCadastro('Data Entrada', _dataEntradaController, TextInputType.text, false, mask: maskData),
                        TextFieldCadastro('Valor de Compra', _valorCompraController, TextInputType.text, false),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                          child: Container(
                            width: 140,
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
                                  );
                                  Provider.of<ProdutoProvider>(context,listen: false).AtualizaListaDeProdutosProvider(context);
                                } else {
                                  ///TRATAR
                                }
                              },
                              child: buttonAverageTitleIconColor(
                                name: 'Cadastrar',
                                iconDoButton: Icons.add_business,
                                corDoTexto: Colors.white,
                                corDoIcon: Colors.white,
                                corDoBotao: Colors.blue,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
              )
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 500,

                color: const Color.fromARGB(50, 204,221, 236),
                //color: const Color.fromARGB(250, 248, 247, 245),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.8,
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Image.asset('img/img-cadatro-produto.png'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(35),
                      //color: Colors.red,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Ao cadastrar seu produto, você terá as seguinte funcionalidades;',
                              style: TextStyle(color: Colors.black54, fontSize: 18, fontFamily: 'Georgia', fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' - Monitorar o estado do produto;',
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontFamily: 'Georgia'),
                            ),
                            Text(
                              '   - Estado da validade do produto.',
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontFamily: 'Georgia'),
                            ),
                            Text(
                              '   - Estado em estoque do produto.',
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontFamily: 'Georgia'),
                            ),
                            Text(
                              ' - Entre outras funcionalidades que ampliará o conhecimento do estado da sua empresa e seus produtos.',
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontFamily: 'Georgia'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

///Pegando os dados informados pelo usuario e montando o objeto empresa para iniciar o cadastro
Future<bool> CadastraProduto(
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
    String valorCompra,
    ) async {

  final timeTicksNow = DateTime.now().millisecondsSinceEpoch;
  String timeUID = timeTicksNow.toString();
  Produto produto = Produto(
   timeUID.toString(),
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
    valorCompra,
  );

  await gravaProduto(context, produto, timeUID).then((value){
    if(value){

      Provider.of<DepositoProvider>(context,listen: false).AtualizaListaDeDepositosProvider(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empresa cadastrada com sucesso !')),
      );
      return true;
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe os dados corretamente para efetuar o cadastro da empresa !')),
      );
      return false;
    }

    //value == true ? Navigator.pop(context) : null;
  });
  return false;
}

