
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

///Verifica se o usuario esta logado, se tiver logado envie o usuario para tela Home page
Future<bool> verificarUsuarioLogado(BuildContext context) async {
  FirebaseAuth _auth = await FirebaseAuth.instance;
  User? usuarioLogado = await _auth.currentUser;


  if (usuarioLogado != null) {
    Navigator.pushReplacementNamed(context, "/home");
    return true;
  }
  return false;
}