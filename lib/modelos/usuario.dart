import 'package:flutter/material.dart';

class Usuario{
  String idUsuario;
  String nome;
  String email;
  String idade;
  List<String>? empresas;

  Usuario(
      this.idUsuario,
      this.nome,
      this.email,
      this.idade,
      this.empresas
      );

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUsuario": idUsuario,
      "nome":nome ,
      "email": email,
      "idade": idade,
      "empresas": empresas
    };
    return map;
  }

}