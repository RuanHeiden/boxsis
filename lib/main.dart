
import 'package:boxsis/page/login.dart';
import 'package:boxsis/provider/login_register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deposito Flutter',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        secondaryHeaderColor: const Color.fromARGB(40, 254, 222, 93),
        primaryColorLight: const Color.fromARGB(255, 255,255, 255),
        primaryColorDark: Colors.black45
      ),
        home:MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginRegisterProvider()),
        ],
        child: LoginPage()),
     //2 home: CreateUser(),
    );
  }
}