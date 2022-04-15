import 'package:boxsis/view/button/button_average_title_icon_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ModalCadastraEmpresa(BuildContext context) {

  final _formKeyCadastraEmpresa = GlobalKey<FormState>();
  final _nomeEmpresaController = TextEditingController();
  final _nomeFantasiaEmpresaController = TextEditingController();
  final _descricaoEmpresaController = TextEditingController();
  final _cnpjEmpresaController = TextEditingController();
  final _telefoneEmpresaController = TextEditingController();
  final _segmentoEmpresaController = TextEditingController();
  final _enderecoEmpresaController = TextEditingController();
  final _numeroFuncionariosEmpresaController = TextEditingController();

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
                    TextFieldCadastro('Nome', _nomeEmpresaController),
                    TextFieldCadastro('Nome Fantasia', _nomeFantasiaEmpresaController),
                    TextFieldCadastro('Descrição', _descricaoEmpresaController),
                    TextFieldCadastro('CNPJ', _cnpjEmpresaController),
                    TextFieldCadastro('Telefone', _telefoneEmpresaController),
                    TextFieldCadastro('Segmento', _segmentoEmpresaController),
                    TextFieldCadastro('Endereço', _enderecoEmpresaController),
                    TextFieldCadastro('Total Funcionarios', _numeroFuncionariosEmpresaController),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                      child: Container(
                          width: 140,
                          height: 40,
                          child: InkWell(
                            onTap: (){},
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
                color: Color.fromARGB(250, 248, 247, 245),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Image.asset('img/img-cadatro-empresa.jpg'),
                    ),
                    Container(
                      padding: EdgeInsets.all(35),
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

Widget TextFieldCadastro(String nameText, TextEditingController numeroFuncionariosEmpresaController) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    //width: 350,
    height: 50,
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
      validator: (text) {
        if (text!.isEmpty) return "Informe um ${nameText} !";
      },
    ),
  );
}