import 'package:boxsis/page/home/home.dart';
import 'package:boxsis/page/login.dart';
import 'package:flutter/material.dart';

import '../page/home/web/depositos_web.dart';
import '../page/home/web/produto_web.dart';

class Rotas{

  static Route<dynamic> gerarRota(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "/home":
        return MaterialPageRoute(builder: (_) => const Home());
      case "/depositos":
        return MaterialPageRoute(builder: (_) => const DepositoWeb());
      case "/produtos":
        return MaterialPageRoute(builder: (_) => const ProdutoWeb());
    }
    return _erroRota();
  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(title: const Text("Tela não encontrada!"),),
        body: const Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }

}