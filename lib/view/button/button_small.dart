///Button COlor
///icon, icon color
import 'package:boxsis/themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget ButtonSmallIcon(BuildContext context, FirebaseAuth auth, IconData IconIcon, Color containerColor, Color iconColors){
  return Container(
    height: 30,
    width: 30,
    decoration:BoxDecoration(
        //color: containerColor,
        borderRadius: const BorderRadius.all(
            Radius.circular(10)
        ),
        border: Border.all(
          width: 0.5,
          color: Colors.grey
        )
    ),
    child: Icon(IconIcon, color: iconColors, size: 18),
  );
}