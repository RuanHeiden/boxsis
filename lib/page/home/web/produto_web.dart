import 'package:boxsis/page/view-cadastros/cadastra_produto.dart';
import 'package:boxsis/page/view_detalhes/detalhes_produto.dart';
import 'package:boxsis/page/view_detalhes/detalhes_usuario.dart';
import 'package:boxsis/provider/deposito_provider.dart';
import 'package:boxsis/provider/home_empresa.dart';
import 'package:boxsis/provider/produto_provider.dart';
import 'package:boxsis/services/firebase/produto_firestore.dart';
import 'package:boxsis/view/block_logo_line.dart';
import 'package:boxsis/view/button/button_average_title_icon_color.dart';
import 'package:boxsis/view/button/button_small.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view/button/button_top_menu.dart';

class ProdutoWeb extends StatefulWidget {
  const ProdutoWeb({Key? key}) : super(key: key);

  @override
  _ProdutoWebState createState() => _ProdutoWebState();
}

class _ProdutoWebState extends State<ProdutoWeb> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _filtroProdutoController = TextEditingController();
  @override
  void initState() {
    ///Chamando o Provider que busca a lista de depositos
    Provider.of<ProdutoProvider>(context, listen: false).AtualizaListaDeProdutosProvider(context);
    getProduto(context);
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
          leading: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Provider.of<ProdutoProvider>(context, listen: false).limpaListaProdutoProvider();
                Provider.of<DepositoProvider>(context, listen: false).limpaDepositoSelecionada();
                Navigator.pushReplacementNamed(context, '/depositos');
              },
              hoverColor: Colors.grey.shade100,
              focusColor: Colors.yellow,
              splashColor: Colors.yellow,
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
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
                  ButtonTopMenuHomePage(context, 'Home', '/home'),
                  const SizedBox(width: 10),
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)
                            )
                        ),
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        child: Text('Em breve', style: TextStyle(color: Colors.orange, fontSize: 9),),
                      ),
                      ButtonTopMenuHomePage(context, 'Dashboard' , null),
                    ],
                  ),
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
                      child: InkWell(
                        child: ButtonSmallIcon(
                          context,
                          Icons.person,
                          Colors.grey.shade100,
                          Colors.grey,
                        ),
                        onTap: (){
                          modalDadosDoUsuario(context);
                        },
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
                        topContainerCenterPage(context, Icons.inventory, 'Lista de Produtos', Colors.red.shade400),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              width: 160,
                              height: 50,
                              child: InkWell(
                                onTap: () {
                                  ModalCadastraProduto(context);
                                },
                                child: buttonAverageTitleIconColor(name: 'Novo Produto', corDoTexto: Colors.white, iconDoButton: Icons.add, corDoIcon: Colors.white, corDoBotao: Colors.blueAccent),
                              ),
                            ),
                            Row(
                              children: [
                                // Material(
                                //   color: Colors.transparent,
                                //   child: InkWell(
                                //     hoverColor: Colors.grey.shade100,
                                //     focusColor: Colors.yellow,
                                //     splashColor: Colors.yellow,
                                //     borderRadius: BorderRadius.circular(10),
                                //     onTap: () async {},
                                //     child: ButtonSmallIcon(
                                //       context,
                                //       Icons.apps,
                                //       Colors.grey.shade100,
                                //       Colors.grey,
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   width: 5,
                                // ),
                                // Material(
                                //   color: Colors.transparent,
                                //   child: InkWell(
                                //     hoverColor: Colors.grey.shade100,
                                //     focusColor: Colors.yellow,
                                //     splashColor: Colors.yellow,
                                //     borderRadius: BorderRadius.circular(10),
                                //     onTap: () async {},
                                //     child: ButtonSmallIcon(
                                //       context,
                                //       Icons.menu,
                                //       Colors.grey.shade100,
                                //       Colors.grey,
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  width: 10,
                                ),


                                Container(
                                  width: 200,
                                  height: 40,
                                  child: TextFormField(
                                    obscureText: false,
                                    controller: _filtroProdutoController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                        color: Colors.black54,
                                      ),
                                      labelText: 'Filtro',
                                    ),
                                    onChanged: (value){
                                      Provider.of<ProdutoProvider>(context, listen: false).filtrandoDireto(value);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    hoverColor: Colors.grey.shade100,
                                    focusColor: Colors.yellow,
                                    splashColor: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () async {
                                      ///Limpa filtro direto
                                      _filtroProdutoController.text = '';
                                      Provider.of<ProdutoProvider>(context, listen: false).filtrandoDireto('');
                                    },
                                    child: ButtonSmallIcon(
                                      context,
                                      Icons.close,
                                      Colors.grey.shade100,
                                      Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                // InkWell(
                                //   onTap: () {},
                                //   child: Container(
                                //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                //     width: 160,
                                //     height: 50,
                                //     child: buttonAverageTitleIconColor(name: 'Filtros', corDoTexto: Colors.white, iconDoButton: Icons.search, corDoIcon: Colors.white, corDoBotao: Colors.orange),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                        context.watch<DepositoProvider>().depositos.isEmpty
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Nenhum deposito cadastrado !',
                                    style: TextStyle(color: Colors.grey.shade300, fontSize: 18),
                                  ),
                                  Icon(
                                    Icons.playlist_add_outlined,
                                    color: Colors.grey.shade300,
                                    size: 50,
                                  ),
                                ],
                              ))
                            : Expanded(
                                child: Card(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children:
                                      context.watch<ProdutoProvider>().textFieldDiretoProduto == '' ?
                                      context
                                          .watch<ProdutoProvider>()
                                          .produtos
                                          .map(
                                            (produto) => Padding(
                                              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
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
                                                  onTap: () {},
                                                  leading: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.red.shade400,
                                                      child: const Icon(
                                                        Icons.inventory,
                                                        size: 25,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  title: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(produto.nomeProduto),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          'Estoque: ${produto.quantidade}',
                                                          style: const TextStyle(color: Colors.black54),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          'Custo: R\$: ${produto.valorCompra}',
                                                          style: const TextStyle(color: Colors.black54),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          'Ref: ${produto.codigoRef}',
                                                          style: const TextStyle(color: Colors.black54),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text('Grupo: ${produto.grupo}'),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text("Marca: ${produto.marca}"),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      hoverColor: Colors.grey.shade100,
                                                      focusColor: Colors.yellow,
                                                      splashColor: Colors.yellow,
                                                      borderRadius: BorderRadius.circular(10),
                                                      onTap: () async {
                                                        ModalDetalhesDoProduto(context, produto);
                                                      },
                                                      child: ButtonSmallIcon(
                                                        context,
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
                                          .toList()
                                          :
                                          context.watch<ProdutoProvider>().produtos
                                          .where((element) => element.nomeProduto.toLowerCase().contains(context.watch<ProdutoProvider>().textFieldDiretoProduto.toLowerCase()))
                                          .map((produto) => Padding(
                                            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
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
                                                onTap: () {},
                                                leading: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.red.shade400,
                                                    child: const Icon(
                                                      Icons.inventory,
                                                      size: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                title: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(produto.nomeProduto),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'Estoque: ${produto.quantidade}',
                                                        style: const TextStyle(color: Colors.black54),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'Custo: ${produto.valorCompra}',
                                                        style: const TextStyle(color: Colors.black54),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        'Ref: ${produto.codigoRef}',
                                                        style: const TextStyle(color: Colors.black54),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text('Grupo: ${produto.grupo}'),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text("Marca: ${produto.marca}"),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                trailing: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    hoverColor: Colors.grey.shade100,
                                                    focusColor: Colors.yellow,
                                                    splashColor: Colors.yellow,
                                                    borderRadius: BorderRadius.circular(10),
                                                    onTap: () async {
                                                      ModalDetalhesDoProduto(context, produto);
                                                    },
                                                    child: ButtonSmallIcon(
                                                      context,
                                                      Icons.edit,
                                                      Colors.grey.shade100,
                                                      Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ).toList()
                                    ),
                                  ),
                                ),
                              ),
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

Widget topContainerCenterPage(BuildContext context, IconData iconContainer, String title, Color color) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
      //color: Colors.grey.shade100,
      border: Border.all(color: Colors.grey.shade300, width: 0.5),
    ),
    height: 50,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CircleAvatar(
              backgroundColor: color,
              child: Icon(
                iconContainer,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
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
