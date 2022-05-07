
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