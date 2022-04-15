import 'package:flutter/material.dart';

  @override
  Widget buttonAverageTitleIconColor
  ({
    String name = 'Button',
    IconData iconDoButton = Icons.warning_amber_outlined,
    Color corDoBotao = Colors.white,
    Color corDoTexto = Colors.black,
    Color corDoIcon = Colors.black,
  }) {
      return Container(
          child: Container(
            height: 55,
            width: 180,
            decoration: BoxDecoration(
              color: corDoBotao,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(name,
                    style: TextStyle(
                      fontSize: 16,
                      color: corDoIcon,
                    ),),
                ),
                Icon(iconDoButton,
                  size: 20,
                  color: corDoIcon,)
              ],
            ),
          ),
      );
  }