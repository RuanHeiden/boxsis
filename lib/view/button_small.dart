///Button COlor
///icon, icon color

import 'package:boxsis/themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget ButtonSmallIcon(BuildContext context, FirebaseAuth auth, IconData IconIcon, Color containerColor, Color iconColors){
  return Container(
    decoration:BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.all(
            Radius.circular(10)
        )
    ),
    child: IconButton(
      onPressed: () async{
        await auth.signOut();
        Navigator.pushReplacementNamed(context, '/login');
      },
      icon: Icon(IconIcon, color: iconColors),
    ),
  );
}