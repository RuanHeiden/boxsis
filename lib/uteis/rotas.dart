import 'package:boxsis/page/home.dart';
import 'package:boxsis/page/login.dart';
import 'package:flutter/material.dart';

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