import 'dart:html';

import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/modelos/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
String? idAuth = _auth.currentUser?.uid;

///Grava empresa
Future<bool> GravaEmpresa(BuildContext context, Empresa empresa, String timeUID) async {
  ///Verifica Login
  try {
    print(_auth.currentUser?.uid);
    var idPessoaLogada = _auth.currentUser?.uid;

    ///Cadastra empresas na lista do usuario logado

    List<String> arrayDeIdEmpresa =  await getEmpresasUsuarioLogado(idPessoaLogada!);

    arrayDeIdEmpresa.add(timeUID);

    Map<String, dynamic> listaDeEmpresas = {
      'empresas' : arrayDeIdEmpresa
    };


    final usuarioRef = _firebaseFirestore
          .collection('Usuarios')
          .doc(idPessoaLogada);
    await usuarioRef.update(listaDeEmpresas);


    ///cadastra na lista de empresas
    final empresaRef =
    _firebaseFirestore
        .collection('Empresas')
        .doc(timeUID);

    await empresaRef.set(empresa.toMap());

    return true;
  } catch (e) {
    print('Algo de errado na tela de cadastro da empresa');
    return false;
  }
}


Future<List> getEmpresa() async {
  var idPessoa = _auth.currentUser?.uid;

  var snapshotsEmpresa222 = await _firebaseFirestore.collection('Empresas').doc(idPessoa.toString()).get();
  // print(snapshotsEmpresa.docs[0].id);


  var idPessoaLogada = _auth.currentUser?.uid;
  var ListaDeEmpresas = [];
  List<String> arrayDeIdEmpresa =  await getEmpresasUsuarioLogado(idPessoaLogada!);


  for(int i = 0; i < arrayDeIdEmpresa.length; i++){
    var snapshotsEmpresa = await _firebaseFirestore.collection('Empresas').doc(arrayDeIdEmpresa[i]).get();

    ListaDeEmpresas.add(snapshotsEmpresa.data());
  }
  // print(snapshotsEmpresa.docs[0].id);
  return ListaDeEmpresas;
}


Future<List<String>> getEmpresasUsuarioLogado(String idPessoaLogada) async {
  var snapshotsEmpresa = await _firebaseFirestore.collection('Usuarios').doc(idPessoaLogada).get();
  List<String> arrayDeIdEmpresa = [];
  for (int i = 0; i < snapshotsEmpresa['empresas'].length; i++) {
    arrayDeIdEmpresa.add(snapshotsEmpresa['empresas'][i]);
  }
  print('idPessoaLogada $idPessoaLogada ');
  print('snapshotsEmpresa $snapshotsEmpresa');
  return arrayDeIdEmpresa;
}


Future<bool> DeletaEmpresa(BuildContext context, Empresa empresa) async {

  try {

    var idPessoaLogada = _auth.currentUser?.uid;

    ///Cadastra empresas na lista do usuario logado

    List<String> arrayDeIdEmpresa =  await getEmpresasUsuarioLogado(idPessoaLogada!);

    arrayDeIdEmpresa.remove(empresa.uid);

    Map<String, dynamic> listaDeEmpresas = {
      'empresas' : arrayDeIdEmpresa
    };


    final usuarioRef = _firebaseFirestore
        .collection('Usuarios')
        .doc(idPessoaLogada);
    await usuarioRef.update(listaDeEmpresas);


    final documentRef = _firebaseFirestore.collection('Empresas').doc(empresa.uid);

    documentRef.delete().then((value) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empresa excluida com sucesso !')),
      );
    });

    return true;
  } catch (e) {
    print('Algo de errado na tela de Deleta da empresa');
    return false;
  }
}


