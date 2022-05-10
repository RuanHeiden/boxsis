import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/provider/home_empresa.dart';
import 'package:boxsis/services/firebase/empresa_firestore.dart';
import 'package:boxsis/view/button/button_average_title_icon_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

ModalCadastraEmpresa(BuildContext context) {
  final _formKeyCadastraEmpresa = GlobalKey<FormState>();
  final _nomeEmpresaController = TextEditingController();
  final _nomeFantasiaEmpresaController = TextEditingController();
  final _descricaoEmpresaController = TextEditingController();
  final _cnpjEmpresaController = TextEditingController();
  final _telefoneEmpresaController = TextEditingController();
  final _segmentoEmpresaController = TextEditingController();
  final _enderecoEmpresaController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: Row(
          children: [
            Expanded(
              flex: 1,
              child: Form(
                key: _formKeyCadastraEmpresa,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 25, bottom: 40),
                        child: Text(
                          'Cadastre sua empresa',
                          style: TextStyle(color: Colors.black54, fontSize: 23),
                        ),
                      ),
                    ),
                    TextFieldCadastro('Nome', _nomeEmpresaController, TextInputType.text, true),
                    TextFieldCadastro('Nome Fantasia', _nomeFantasiaEmpresaController, TextInputType.text, true),
                    TextFieldCadastro('Descrição', _descricaoEmpresaController, TextInputType.text, false),
                    TextFieldCadastro('CNPJ', _cnpjEmpresaController, TextInputType.number, true),
                    TextFieldCadastro('Telefone', _telefoneEmpresaController, TextInputType.phone, false),
                    TextFieldCadastro('Segmento', _segmentoEmpresaController, TextInputType.text, false),
                    TextFieldCadastro('Endereço', _enderecoEmpresaController, TextInputType.text, false),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                      child: Container(
                        width: 140,
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
                                _enderecoEmpresaController.text
                              ).then((value){
                                if(value){
                                  Provider.of<HomeProvicer>(context,listen: false).AtualizaListaDeEmpresasProvider();
                                }else{

                                }
                              });

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
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 500,
                color: const Color.fromARGB(250, 248, 247, 245),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.8,
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Image.asset('img/img-cadatro-empresa.jpg'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(35),
                      //color: Colors.red,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Ao cadastrar sua empresa, você terá as seguinte funcionalidades;',
                              style: TextStyle(color: Colors.black54, fontSize: 18, fontFamily: 'Georgia', fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' - Cadastro de vários depósitos.',
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
Future<bool> CadastraEmpresa(
  BuildContext context,
  String nomeEmpresa,
  String nomeFantasia,
  String descricao,
  String cnpj,
  String telefone,
  String segmento,
  String endereco,
) async {

  final timeTicksNow = DateTime.now().millisecondsSinceEpoch;
  String timeUID = timeTicksNow.toString();
  //ruan
  Empresa empresa = Empresa(
    timeUID,
    nomeEmpresa,
    nomeFantasia,
    descricao,
    cnpj,
    telefone,
    segmento,
    endereco,
  );

  await GravaEmpresa(context, empresa, timeUID).then((value){
    if(value){
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
