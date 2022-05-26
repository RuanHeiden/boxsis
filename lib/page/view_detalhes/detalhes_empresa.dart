import 'package:boxsis/mask/mask.dart';
import 'package:boxsis/modelos/deposito.dart';
import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/provider/deposito_provider.dart';
import 'package:boxsis/provider/home_empresa.dart';
import 'package:boxsis/services/firebase/empresa_firestore.dart';
import 'package:boxsis/view/button/button_average_title_icon_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../view/my_textfield.dart';
import '../view-cadastros/cadastra_deposito.dart';

ModalDetalhesDaEmpresa(BuildContext context, Empresa empresa) {
  final _formKeyCadastraEmpresa = GlobalKey<FormState>();
  final _nomeEmpresaController = TextEditingController( text: empresa.nomeEmpresa);
  final _nomeFantasiaEmpresaController = TextEditingController(text: empresa.nomeFantasia);
  final _descricaoEmpresaController = TextEditingController(text: empresa.descricao);
  final _cnpjEmpresaController = TextEditingController(text: empresa.cnpj);
  final _telefoneEmpresaController = TextEditingController(text: empresa.telefone);
  final _segmentoEmpresaController = TextEditingController(text: empresa.segmento);
  final _enderecoEmpresaController = TextEditingController(text: empresa.endereco);

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
                  child:SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 40),
                            child: Text(
                              'Detalhes da Empresa ${empresa.nomeEmpresa}',
                              style: TextStyle(color: Colors.black54, fontSize: 23),
                            ),
                          ),
                        ),
                        TextFieldCadastro('Nome', _nomeEmpresaController, TextInputType.text, true,),
                        TextFieldCadastro('Nome Fantasia', _nomeFantasiaEmpresaController, TextInputType.text, true),
                        TextFieldCadastro('Descrição', _descricaoEmpresaController, TextInputType.text, false),
                        TextFieldCadastro('CNPJ', _cnpjEmpresaController, TextInputType.number, true, mask: maskCNPJ),
                        TextFieldCadastro('Telefone', _telefoneEmpresaController, TextInputType.phone, false, mask: maskTelefone),
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
                                    onTap: ()  async {
                                      await Provider.of<HomeProvicer>(context,listen: false).selecionadaEmpresa(empresa.uid.toString());
                                      await Provider.of<DepositoProvider>(context, listen: false).AtualizaListaDeDepositosProvider(context);

                                     if(Provider.of<DepositoProvider>(context, listen: false).depositos.isNotEmpty){
                                       ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(content: Text('Exclua todos os depósitos cadastrados antes de excluir a empresa ${empresa.nomeEmpresa}', style: TextStyle(color: Colors.white),)),
                                       );
                                     }else{
                                          await DeletaEmpresa(context, empresa);
                                          Provider.of<HomeProvicer>(context, listen: false).AtualizaListaDeEmpresasProvider();
                                     }

                                      await Provider.of<HomeProvicer>(context,listen: false).limpaEmpresaSelecionada();
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
                                        CadastraEmpresa(
                                          context,
                                          _nomeEmpresaController.text,
                                          _nomeFantasiaEmpresaController.text,
                                          _descricaoEmpresaController.text,
                                          _cnpjEmpresaController.text,
                                          _telefoneEmpresaController.text,
                                          _segmentoEmpresaController.text,
                                          _enderecoEmpresaController.text,
                                          empresa.uid.toString(),
                                        );

                                        Provider.of<HomeProvicer>(context,listen: false).AtualizaListaDeEmpresasProvider();
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
CadastraEmpresa(
    BuildContext context,
    String nomeEmpresa,
    String nomeFantasia,
    String descricao,
    String cnpj,
    String telefone,
    String segmento,
    String endereco,
    String oldUID,
) async {

  //
  // final timeTicksNow = DateTime.now().millisecondsSinceEpoch;
  // String timeUID = timeTicksNow.toString();

  Empresa empresa = Empresa(
    oldUID,
    nomeEmpresa,
    nomeFantasia,
    descricao,
    cnpj,
    telefone,
    segmento,
    endereco,
  );
  await GravaEmpresa(context, empresa, oldUID).then((value){
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

