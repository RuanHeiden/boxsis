import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/page/view-cadastros/cadatra_empresa.dart';
import 'package:boxsis/page/view_detalhes/detalhes_empresa.dart';
import 'package:boxsis/provider/home_empresa.dart';
import 'package:boxsis/services/busca_empresas_cadastrada.dart';
import 'package:boxsis/services/firebase/empresa_firestore.dart';
import 'package:boxsis/themes/colors.dart';
import 'package:boxsis/view/block_logo_line.dart';
import 'package:boxsis/view/button/button_average_title_icon_color.dart';
import 'package:boxsis/view/button/button_small.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../view/button/button_top_menu.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({Key? key}) : super(key: key);

  @override
  _HomeWebState createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void initState() {
    ///Chamando o Provider que busca a lista de empresas
    Provider.of<HomeProvicer>(context, listen: false).AtualizaListaDeEmpresasProvider();
    super.initState();
  }

  void deslogaUsuario() async {
    await _auth.signOut();
    Provider.of<HomeProvicer>(context, listen: false).deslogaUsuarioProvider();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 45,
          //backgroundColor: PaletaCores.corSinzaClaro,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///Logo e menu
              Row(
                children: [
                  ContainerLogoLine(context),
                  const SizedBox(width: 40.0),
                  ButtonTopMenuHomePage(context, 'Home'),
                  const SizedBox(width: 10),
                  ButtonTopMenuHomePage(context, 'Cadastro'),
                  const SizedBox(width: 10),
                  ButtonTopMenuHomePage(context, 'Dashboard'),
                ],
              ),

              ///Icon de opções a direita
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      hoverColor: Colors.grey.shade100,
                      focusColor: Colors.yellow,
                      splashColor: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        print('teste');
                      },
                      child: ButtonSmallIcon(
                        context,
                        _auth,
                        Icons.person,
                        Colors.grey.shade100,
                        Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      hoverColor: Colors.grey.shade100,
                      focusColor: Colors.yellow,
                      splashColor: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                      onTap: () async {
                        await _auth.signOut();
                        Navigator.pushReplacementNamed(context, '/login');

                        Provider.of<HomeProvicer>(context, listen: false).deslogaUsuarioProvider();
                      },
                      child: ButtonSmallIcon(
                        context,
                        _auth,
                        Icons.logout,
                        Colors.grey.shade100,
                        Colors.grey,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TopContainerCenterPage(context, Icons.apartment_outlined, 'Lista de Empresas'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              width: 160,
                              height: 50,
                              child: InkWell(
                                onTap: () {
                                  ModalCadastraEmpresa(context);
                                },
                                child: buttonAverageTitleIconColor(name: 'Nova Empresa', corDoTexto: Colors.white, iconDoButton: Icons.add, corDoIcon: Colors.white, corDoBotao: Colors.blueAccent),
                              ),
                            ),
                            Row(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    hoverColor: Colors.grey.shade100,
                                    focusColor: Colors.yellow,
                                    splashColor: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () async {},
                                    child: ButtonSmallIcon(
                                      context,
                                      _auth,
                                      Icons.apps,
                                      Colors.grey.shade100,
                                      Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    hoverColor: Colors.grey.shade100,
                                    focusColor: Colors.yellow,
                                    splashColor: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () async {},
                                    child: ButtonSmallIcon(
                                      context,
                                      _auth,
                                      Icons.menu,
                                      Colors.grey.shade100,
                                      Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    width: 160,
                                    height: 50,
                                    child: buttonAverageTitleIconColor(name: 'Filtros', corDoTexto: Colors.white, iconDoButton: Icons.search, corDoIcon: Colors.white, corDoBotao: Colors.orange),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        ///Verificando se a empresa cadastrada
                        context.watch<HomeProvicer>().empresas.isEmpty

                            /// se não, mostrar um text com icon
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Nenhuma Empresa cadastrada !',
                                    style: TextStyle(color: Colors.grey.shade300, fontSize: 18),
                                  ),
                                  Icon(
                                    Icons.playlist_add_outlined,
                                    color: Colors.grey.shade300,
                                    size: 50,
                                  ),
                                ],
                              ))

                            /// se sim, mostrar a lista
                            : Expanded(
                                child: Card(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: context
                                          .watch<HomeProvicer>()
                                          .empresas
                                          .map(
                                            (empresa) =>
                                                Padding(
                                              padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.5),
                                                      spreadRadius: 3,
                                                      blurRadius: 7,
                                                      offset: const Offset(0, 3), // changes position of shadow
                                                    ),
                                                  ],
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                child: ListTile(
                                                  onTap: () {
                                                  },
                                                  leading: const Icon(
                                                    Icons.apartment_outlined,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  ),
                                                  title: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(empresa.nomeEmpresa),
                                                      const SizedBox(
                                                        width: 30,
                                                      ),
                                                      Text(
                                                        'CNPJ: ${empresa.cnpj}',
                                                        style: TextStyle(color: Colors.black54),
                                                      ),
                                                      const SizedBox(
                                                        width: 30,
                                                      ),
                                                      Text(
                                                        'Telefone: ${empresa.telefone}',
                                                        style: TextStyle(color: Colors.black54),
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Text(empresa.descricao),
                                                  trailing:  Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      hoverColor: Colors.grey.shade100,
                                                      focusColor: Colors.yellow,
                                                      splashColor: Colors.yellow,
                                                      borderRadius: BorderRadius.circular(10),
                                                      onTap: () async {
                                                        ModalDetalhesDaEmpresa(context, empresa);
                                                      },
                                                      child: ButtonSmallIcon(
                                                        context,
                                                        _auth,
                                                        Icons.edit,
                                                        Colors.grey.shade100,
                                                        Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
              ///Blocos laterais para o dashboard futuros
              Expanded(
                flex: 0,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 5),
                        child: Container(
                          color: Colors.red.shade100,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 8),
                        child: Container(
                          color: Colors.blue.shade100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget TopContainerCenterPage(BuildContext context, IconData IconContainer, String title) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
      //color: Colors.grey.shade100,
      border: Border.all(color: Colors.grey.shade300, width: 0.5),
    ),
    height: 40,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Icon(
              IconContainer,
              //color: Colors.blue.shade400,
              color: Colors.black54,
              size: 28,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: SizedBox(
              height: 10,
              width: 10,
            ),
          ),
        ],
      ),
    ),
  );
}
