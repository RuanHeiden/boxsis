
import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/modelos/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
String? idAuth = _auth.currentUser?.uid;

GravaRestanteDosDadosDoUsuario(BuildContext context, Usuario usuario) {
  final usuarioRef = _firebaseFirestore.collection('usuarios');
  usuarioRef.doc(usuario.idUsuario).set(usuario.toMap()).then((value) {
    print('Entro no then !!!');
  });
}

///Grava empresa
Future<bool> GravaEmpresa(BuildContext context, Empresa empresa) async{
  ///Verifica Login
  try{
    print(_auth.currentUser?.uid);
    final timeTicksNow = DateTime.now().millisecondsSinceEpoch;

    final usuarioRef = _firebaseFirestore.collection('usuarios').doc(idAuth);
    await usuarioRef.collection('Empresa').doc(timeTicksNow.toString()).set(empresa.toMap());

    return true;
  }catch(e){
    print('Algo de errado na tela de cadastro da empresa');
    return false;
  }
}


Future<QuerySnapshot<Map<String, dynamic>>> getEmpresa() async{
      var snapshotsEmpresa = await _firebaseFirestore
          .collection('usuarios')
          .doc(idAuth.toString())
          .collection('Empresa')
          .get();
      //print(snapshotsEmpresa.docs[0].data());
  return snapshotsEmpresa;
}