

import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/modelos/usuario.dart';
import 'package:boxsis/provider/usuario_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
String? idAuth = _auth.currentUser?.uid;

///Grava empresa
Future<bool> findUsuario(BuildContext context) async {
  try {
    var idPessoa = _auth.currentUser?.uid;
    var responseUsuario = await _firebaseFirestore.collection('Usuarios').doc(idPessoa.toString()).get();

    Usuario _usuario = Usuario(
        responseUsuario.id,
        responseUsuario.data()!['nome'],
        responseUsuario.data()!['email'],
        responseUsuario.data()!['idade'],
        [],
    );

    Provider.of<UsuarioProvider>(context,listen: false).gravaUsuarioProvider(_usuario);

    return true;
  } catch (e) {
    print('Algo de errado na tela de buscar dados do usuario : $e');
    return false;
  }
}
