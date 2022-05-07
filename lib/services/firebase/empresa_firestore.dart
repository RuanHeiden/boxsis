
import 'dart:html';

import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/modelos/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
String? idAuth = _auth.currentUser?.uid;


///Grava empresa
Future<bool> GravaEmpresa(BuildContext context, Empresa empresa, String timeUID) async{

  ///Verifica Login
  try{
    print(_auth.currentUser?.uid);

    final usuarioRef = _firebaseFirestore.collection('usuarios').doc(idAuth);
    await usuarioRef.collection('Empresa').doc(timeUID).set(empresa.toMap());

    return true;
  }catch(e){
    print('Algo de errado na tela de cadastro da empresa');
    return false;
  }
}

Future<bool> DeletaEmpresa(BuildContext context, Empresa empresa) async{
  try{

    final documentRef = _firebaseFirestore.collection('usuarios').doc(idAuth).collection('Empresa').doc(empresa.uid);
    documentRef.delete();

    return true;
  }catch(e){
    print('Algo de errado na tela de Deleta da empresa');
    return false;
  }
}



Future<QuerySnapshot<Map<String, dynamic>>> getEmpresa() async{
      var snapshotsEmpresa = await _firebaseFirestore
          .collection('usuarios')
          .doc(idAuth.toString())
          .collection('Empresa')
          .get();
     // print(snapshotsEmpresa.docs[0].id);
  return snapshotsEmpresa;
}