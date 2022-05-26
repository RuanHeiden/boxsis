import 'package:boxsis/modelos/deposito.dart';
import 'package:boxsis/provider/home_empresa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
String? idAuth = _auth.currentUser?.uid;

Future<bool> gravaDeposito(BuildContext context, Deposito deposito, String timeUID) async {
  try {
    var idPessoaLogada = _auth.currentUser?.uid;

    var idEmpresaSelecionada = Provider.of<HomeProvicer>(context, listen: false).empresaSelecionada;

    final _empresaRef = _firebaseFirestore.collection('Empresas').doc(idEmpresaSelecionada).collection('Depositos').doc(timeUID);
    _empresaRef.set(deposito.toMap());

    return true;
  } catch (e) {
    print('Algo deu errado na tela de cadastro no Deposito $e');
    return false;
  }
}

Future<List> getDeposito(BuildContext context) async {
  try {
    var idEmpresaSelecionada = Provider.of<HomeProvicer>(context, listen: false).empresaSelecionada;

    var snapshotDeposito = await _firebaseFirestore.collection('Empresas').doc(idEmpresaSelecionada).collection('Depositos').get();

    var listaDeEmpresas = [];
    for (int i = 0; i < snapshotDeposito.docs.length; i++) {
      listaDeEmpresas.add(snapshotDeposito.docs[i].data());
    }

    return listaDeEmpresas;
  } catch (e) {
    print('Algo deu errado no obter o deposito $e');
    return [];
  }
}

Future<bool> DeletaDeposito(BuildContext context, Deposito deposito) async {
  try {
    ///Pega o id da empresa selecionada
    var idEmpresaSelecionada = Provider.of<HomeProvicer>(context, listen: false).empresaSelecionada;
    var snapshotDeposito = await _firebaseFirestore.collection('Empresas').doc(idEmpresaSelecionada).collection('Depositos').doc(deposito.uid);
    await snapshotDeposito.delete();
    return true;
  } catch (e) {
    print('Algo deu errado no DeletaDeposito : $e');
    return false;
  }
}
