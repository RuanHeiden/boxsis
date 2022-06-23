
import 'package:boxsis/provider/usuario_provider.dart';
import 'package:boxsis/services/firebase/ususario_firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future modalDadosDoUsuario(BuildContext context) {
  findUsuario(context);
  return showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.person_pin_rounded, color: Colors.grey,size: 80),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              Text('Nome: ${context.watch<UsuarioProvider>().nome}'),
              Text('E-mail: ${context.watch<UsuarioProvider>().email}'),
              Text('Idade: ${context.watch<UsuarioProvider>().idade}'),
            ],
          ),
        ],
      ),
    );
  });

}