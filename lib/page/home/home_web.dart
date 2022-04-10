import 'package:boxsis/themes/colors.dart';
import 'package:boxsis/view/block_logo_line.dart';
import 'package:boxsis/view/button_small.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({Key? key}) : super(key: key);

  @override
  _HomeWebState createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {

  FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: PaletaCores.corSinzaClaro,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ///Logo e menu
                Row(
                  children: [
                    ContainerLogoLine(context),
                    const SizedBox(width: 40.0),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: const BoxDecoration(
                          //color: Colors.white24,
                          color: Colors.white24,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      ),
                      child: const Center(
                          child: Text('teste', style: TextStyle(color: Colors.white),)
                      ),
                    )
                  ],
                ),


                ///Icon de opções a direita
                Row(
                  children: [
                    ButtonSmallIcon(context, _auth, Icons.person, Colors.white24, PaletaCores.corAmareloForte),
                    const SizedBox(width: 3.0),
                    ButtonSmallIcon(context, _auth, Icons.logout, Colors.white24, PaletaCores.corAmareloForte)
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
