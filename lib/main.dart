import 'package:boxsis/page/home/home.dart';
import 'package:boxsis/page/login.dart';
import 'package:boxsis/provider/deposito_provider.dart';
import 'package:boxsis/provider/login_register_provider.dart';
import 'package:boxsis/provider/produto_provider.dart';
import 'package:boxsis/provider/usuario_provider.dart';
import 'package:boxsis/services/firebase/verifica_usuario_logado.dart';
import 'package:boxsis/uteis/rotas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/home_empresa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBPYYtF3J4E4rBXsEwoR9X0xS6EIHI6Dbw",
          authDomain: "boxsis-7b245.firebaseapp.com",
          projectId: "boxsis-7b245",
          storageBucket: "boxsis-7b245.appspot.com",
          messagingSenderId: "1098699944504",
          appId: "1:1098699944504:web:9fe44de3c26ac7cb42accd"
      ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginRegisterProvider()),
          ChangeNotifierProvider(create: (_) => HomeProvicer()),
          ChangeNotifierProvider(create: (_) => DepositoProvider(),),
          ChangeNotifierProvider(create: (_) => ProdutoProvider(),),
          ChangeNotifierProvider(create: (_) => UsuarioProvider(),)
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sis.Box',
          ///Colors primárias para inicialização de cores
          theme: ThemeData(
              primarySwatch: Colors.yellow,
              secondaryHeaderColor: const Color.fromARGB(40, 254, 222, 93),
              primaryColorLight: const Color.fromARGB(255, 255, 255, 255),
              primaryColorDark: Colors.black45
          ),
          initialRoute: "/",
          onGenerateRoute: Rotas.gerarRota,

        )
    );
  }
}


