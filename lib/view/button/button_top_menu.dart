
import 'package:flutter/material.dart';
import 'package:boxsis/themes/colors.dart';

Widget ButtonTopMenuHomePage(BuildContext context, title) {
  bool hoverColors = false;

  return Material(
    color: Colors.transparent,
    child: InkWell(
      hoverColor: Colors.grey.shade100,
      focusColor: Colors.yellow,
      splashColor: Colors.yellow,
      onTap: () {},
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