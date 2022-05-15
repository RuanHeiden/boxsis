import 'package:boxsis/modelos/deposito.dart';
import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/page/view-cadastros/cadastra_deposito.dart';
import 'package:boxsis/provider/deposito_provider.dart';
import 'package:boxsis/provider/home_empresa.dart';
import 'package:boxsis/services/firebase/deposito_firestore.dart';
import 'package:boxsis/services/firebase/empresa_firestore.dart';
import 'package:boxsis/view/button/button_average_title_icon_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

ModalDetalhesDaDeposito(BuildContext context, Deposito deposito) {
  final _formKeyCadastraEmpresa = GlobalKey<FormState>();
  final _nomeEmpresaController = TextEditingController( text: deposito.nomeEmpresa);
  final _descricaoEmpresaController = TextEditingController(text: deposito.descricao);
  final _telefoneEmpresaController = TextEditingController(text: deposito.telefone);
  final _segmentoEmpresaController = TextEditingController(text: deposito.segmento);
  final _enderecoEmpresaController = TextEditingController(text: deposito.endereco);

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
                    key: _formKeyCadastraEmpresa,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 40),
                            child: Text(
                              'Detalhes da Empresa ${deposito.nomeEmpresa}',
                              style: TextStyle(color: Colors.black54, fontSize: 23),
                            ),
                          ),
                        ),
                        TextFieldCadastro('Nome', _nomeEmpresaController, TextInputType.text, true),
                        TextFieldCadastro('Descrição', _descricaoEmpresaController, TextInputType.text, false),
                        TextFieldCadastro('Telefone', _telefoneEmpresaController, TextInputType.phone, false),
                        TextFieldCadastro('Segmento', _segmentoEmpresaController, TextInputType.text, false),
                        TextFieldCadastro('Endereço', _enderecoEmpresaController, TextInputType.text, false),
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
                                    onTap: () {
                                      if (_formKeyCadastraEmpresa.currentState!.validate()) {
                                        DeletaDeposito(context, deposito);
                                        Provider.of<DepositoProvider>(context,listen: false).AtualizaListaDeDepositosProvider(context);
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
                                      if (_formKeyCadastraEmpresa.currentState!.validate()) {
                                        CadastraDeposito(
                                          context,
                                          _nomeEmpresaController.text,
                                          _descricaoEmpresaController.text,
                                          _telefoneEmpresaController.text,
                                          _segmentoEmpresaController.text,
                                          _enderecoEmpresaController.text,
                                          deposito.uid.toString() ,
                                        );

                                        Provider.of<DepositoProvider>(context,listen: false).AtualizaListaDeDepositosProvider(context);
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
                        )
                      ],
                    ),
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
CadastraDeposito(
    BuildContext context,
    String nomeEmpresa,
    String descricao,
    String telefone,
    String segmento,
    String endereco,
    String oldUID,
    ) async {

  //
  // final timeTicksNow = DateTime.now().millisecondsSinceEpoch;
  // String timeUID = timeTicksNow.toString();

  Deposito deposito = Deposito(
    oldUID,
    nomeEmpresa,
    descricao,
    telefone,
    segmento,
    endereco,
  );

  await gravaDeposito(context, deposito, oldUID).then((value){
    if(value){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empresa cadastrada com sucesso !')),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe os dados corretamente para efetuar o cadastro da empresa !')),
      );
    }
    //value == true ? Navigator.pop(context) : null;
  });
}

Widget TextFieldCadastro(String nameText, TextEditingController numeroFuncionariosEmpresaController, TextInputType typeText, bool mandatory) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    //width: 350,
    // /height: 50,
    child: TextFormField(
      obscureText: false,
      controller: numeroFuncionariosEmpresaController,

      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
        labelText: nameText.toString(),
      ),
      keyboardType: typeText,
      validator: mandatory
          ? (text) {
        if (text!.isEmpty) return "Informe um ${nameText} !";
      }
          : null,
    ),
  );
}
