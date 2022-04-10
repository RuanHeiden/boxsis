import 'package:boxsis/themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../view/block_logo_line.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  _HomeMobileState createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {

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
                ContainerLogoLine(context),

                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      child: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.person, color:PaletaCores.corAmareloForte,)
                      ),
                    ),
                    const SizedBox(width: 3.0),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                      ),
                      child: IconButton(
                        onPressed: () async{
                          await _auth.signOut();
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        icon: const Icon(Icons.logout, color: PaletaCores.corAmareloForte,),
                      ),
                    ),
                  ],
                )
              ],
            ),
            leading: InkWell(
              hoverColor: PaletaCores.corAmareloFraca,
              child: Container(
                color: Colors.white24,
                child: const Icon(
                  Icons.menu,
                  color: PaletaCores.corAmareloForte,
                ),
              ),
              onTap: (){
                print('Drawer lateral');
              },
            ),
          ),
        )
    );
  }
}
