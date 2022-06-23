
import 'package:boxsis/provider/deposito_provider.dart';
import 'package:boxsis/provider/produto_provider.dart';
import 'package:flutter/material.dart';
import 'package:boxsis/themes/colors.dart';
import 'package:provider/provider.dart';

Widget ButtonTopMenuHomePage(BuildContext context, title, String? rota) {
  bool hoverColors = false;

  return Material(
    color: Colors.transparent,
    child: InkWell(
      hoverColor: Colors.grey.shade100,
      focusColor: Colors.yellow,
      splashColor: Colors.yellow,
      onTap: () {
        Provider.of<DepositoProvider>(context, listen: false).limpaDepositoSelecionada();
        Provider.of<ProdutoProvider>(context, listen: false).limpaListaProdutoProvider();
        if(rota != null){
          Navigator.pushReplacementNamed(context, rota);
        }

      },
      child: Container(
        height: 40,
        width: 120,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.yellow,
              width: 1.5,
            ),
          ),
        ),
        child: Center(
            child: Text(
              '$title',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 17,
              ),
            )),
      ),
    ),
  );
}