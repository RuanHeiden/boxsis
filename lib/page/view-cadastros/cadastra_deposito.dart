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

import '../../services/firebase/deposito_firestore.dart';
import '../../view/my_textfield.dart';

ModalCadastraDeposito(BuildContext context) {
  final _formKeyCadastraDeposito = GlobalKey<FormState>();
  final _nomeDepositoController = TextEditingController();
 // final _nomeFantasiaEmpresaController = TextEditingController();
  final _descricaoDepositoController = TextEditingController();
  //final _cnpjEmpresaController = TextEditingController();
  final _telefoneDepositoController = TextEditingController();
  final _segmentoDepositoController = TextEditingController();
  final _enderecoDepositoController = TextEditingController();

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
                  key: _formKeyCadastraDeposito,
                  child:SingleChildScrollView(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 25, bottom: 40),
                            child: Text(
                              'Cadastre seu deposito',
                              style: TextStyle(color: Colors.black54, fontSize: 23),
                            ),
                          ),
                        ),
                        TextFieldCadastro('Nome', _nomeDepositoController, TextInputType.text, true),
                        // TextFieldCadastro('Nome Fantasia', _nomeFantasiaEmpresaController, TextInputType.text, true),
                        TextFieldCadastro('Descrição', _descricaoDepositoController, TextInputType.text, false),
                        //TextFieldCadastro('CNPJ', _cnpjEmpresaController, TextInputType.number, true),
                        TextFieldCadastro('Telefone', _telefoneDepositoController, TextInputType.phone, false, mask: maskTelefone),
                        TextFieldCadastro('Segmento', _segmentoDepositoController, TextInputType.text, false),
                        TextFieldCadastro('Endereço', _enderecoDepositoController, TextInputType.text, false),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                          child: Container(
                            width: 140,
                            height: 40,
                            child: InkWell(
                              onTap: () {
                                if (_formKeyCadastraDeposito.currentState!.validate()) {
                                  CadastraDeposito(
                                      context,
                                      _nomeDepositoController.text,
                                      _descricaoDepositoController.text,
                                      _telefoneDepositoController.text,
                                      _segmentoDepositoController.text,
                                      _enderecoDepositoController.text
                                  );
                                  // CadastraEmpresa(
                                  //     context,
                                  //     _nomeEmpresaController.text,
                                  //     _nomeFantasiaEmpresaController.text,
                                  //     _descricaoEmpresaController.text,
                                  //     //_cnpjEmpresaController.text,
                                  //     _telefoneEmpresaController.text,
                                  //     _segmentoEmpresaController.text,
                                  //     _enderecoEmpresaController.text
                                  // ).then((value){
                                  //   if(!value){
                                  //     Provider.of<HomeProvicer>(context,listen: false).AtualizaListaDeEmpresasProvider();
                                  //   }
                                  //});

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
                      child: Image.asset('img/img-cadastro-deposito.png'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(35),
                      //color: Colors.red,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Ao cadastrar seu deposito, você terá as seguinte funcionalidades;',
                              style: TextStyle(color: Colors.black54, fontSize: 18, fontFamily: 'Georgia', fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' - Cadastro de produtos.',
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontFamily: 'Georgia'),
                            ),
                            Text(
                              ' - Dashboard em tempo real.',
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontFamily: 'Georgia'),
                            ),
                            Text(
                              ' - Opções de relatórios específicos.',
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
Future<bool> CadastraDeposito(
    BuildContext context,
    String nomeEmpresa,
    String descricao,
    String telefone,
    String segmento,
    String endereco,
    ) async {

  final timeTicksNow = DateTime.now().millisecondsSinceEpoch;
  String timeUID = timeTicksNow.toString();
  //ruan
  Deposito deposito = Deposito(
     timeUID.toString(),
     nomeEmpresa,
     descricao,
     telefone,
     segmento,
     endereco,
  );

  await gravaDeposito(context, deposito, timeUID).then((value){
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

