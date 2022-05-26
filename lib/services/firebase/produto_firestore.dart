import 'package:boxsis/modelos/produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../provider/deposito_provider.dart';
import '../../provider/home_empresa.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
String? idAuth = _auth.currentUser?.uid;

Future<bool> gravaProduto(BuildContext context, Produto produto, String timeUID) async {
  try {

    ///Pega o id do usuario logado
    var idPessoaLogada = _auth.currentUser?.uid;

    ///Pega o id da empresa selecionada
    var idEmpresaSelecionada = Provider
        .of<HomeProvicer>(context, listen: false)
        .empresaSelecionada;

    var idDepositoSelecionado = Provider
        .of<DepositoProvider>(context, listen: false)
        .depositoSelecionado;

    ///Pega o caminho para chegar na empresa selecionada
    final EmpresaRef = _firebaseFirestore
        .collection('Empresas')
        .doc(idEmpresaSelecionada)
        .collection('Depositos')
        .doc(idDepositoSelecionado)
        .collection('Produtos')
        .doc(timeUID);
    EmpresaRef.set(produto.toMap());

    return true;
  } catch (e) {
    print('Algo de errado no cadastro de produto :$e');
    return false;
  }
}

Future<List> getProduto(BuildContext context) async {
  try {
    var ListaDeProduto = [];

    var idDepositoSelecionado = Provider
        .of<DepositoProvider>(context, listen: false)
        .depositoSelecionado;

    var idEmpresaSelecionada = Provider
        .of<HomeProvicer>(context, listen: false)
        .empresaSelecionada;

    var baseProduto = await _firebaseFirestore
        .collection('Empresas')
        .doc(idEmpresaSelecionada)
        .collection('Depositos')
        .doc(idDepositoSelecionado)
        .collection('Produtos')
        .get();

    for(int i=0; i< baseProduto.docs.length; i++){
      ListaDeProduto.add(baseProduto.docs[i].data());
    }
    return ListaDeProduto;
  } catch (e) {
    print('Algo de errado no buscar de produtos $e');
    return [];
  }
}

Future<bool> DeletaProduto(BuildContext context, Produto produto) async{
  var idDepositoSelecionado = Provider
      .of<DepositoProvider>(context, listen: false)
      .depositoSelecionado;

  var idEmpresaSelecionada = Provider
      .of<HomeProvicer>(context, listen: false)
      .empresaSelecionada;

  try{
    var baseProduto = await _firebaseFirestore
        .collection('Empresas')
        .doc(idEmpresaSelecionada)
        .collection('Depositos')
        .doc(idDepositoSelecionado)
        .collection('Produtos')
        .doc(produto.uid);

    await baseProduto.delete();

    return true;
  }catch(e){
    print('Algo deu errado na exclução do produto $e');
    return false;
  }
}
