import 'package:flutter/material.dart';

class Usuario{
  String idUsuario;
  String nome;
  String email;
  String idade;

  Usuario(
      this.idUsuario,
      this.nome,
      this.email,
      this.idade
      );

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUsuario": idUsuario,
      "nome":nome ,
      "email": email,
      "idade": idade
    };
    return map;
  }

}