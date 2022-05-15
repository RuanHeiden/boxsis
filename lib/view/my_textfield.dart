import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget TextFieldCadastro(String nameText, TextEditingController controller, TextInputType typeText, bool obrigatorio, {MaskTextInputFormatter? mask}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    //width: 350,
    // /height: 50,
    child: TextFormField(
      inputFormatters: mask != null ? [mask] : [],
      obscureText: false,
      controller: controller,

      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
        labelText: nameText.toString(),
      ),
      keyboardType: typeText,
      validator: obrigatorio
          ? (text) {
        if (text!.isEmpty) return "Informe um ${nameText} !";
      }
          : null,
    ),
  );
}
