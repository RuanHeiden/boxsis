
import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/modelos/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

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

    String? idAuth = _auth.currentUser?.uid;
    final usuarioRef = _firebaseFirestore.collection('usuarios').doc(idAuth);
    await usuarioRef.collection('Empresa').doc(timeTicksNow.toString()).set(empresa.toMap());

    return true;
  }catch(e){
    print('Algo de errado na tela de cadastro da empresa');
    return false;
  }


}
