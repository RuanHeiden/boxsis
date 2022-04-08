import 'package:boxsis/modelos/usuario.dart';
import 'package:boxsis/provider/login_register_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKeyLogin = GlobalKey<FormState>();
  final _emailLoginController = TextEditingController();
  final _senhaLoginController = TextEditingController();

  final _formKeyCadastroUsuario = GlobalKey<FormState>();
  final _nomeCadastroController = TextEditingController();
  final _idadeCadastroController = TextEditingController();
  final _emailCadastroController = TextEditingController();
  final _senhaCadastroController = TextEditingController();


  bool _cadastroUsuario = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var MediaHeight = MediaQuery
        .of(context)
        .size
        .height;
    var MediaWeigth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: MediaWeigth < 800 ? Theme
          .of(context)
          .primaryColorLight : Theme
          .of(context)
          .secondaryHeaderColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: MediaWeigth > 1050
                  ? 450
                  : MediaWeigth < 800
                  ? MediaWeigth
                  : MediaWeigth / 2,
              height: MediaWeigth > 1050 ? 600 : MediaHeight,
              decoration: BoxDecoration(
                  boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black45, blurRadius: 15.0, offset: Offset(5.9, 5.75))],
                  color: Theme
                      .of(context)
                      .primaryColorLight,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Container(
                      height: 200,
                      padding: const EdgeInsets.all(5),
                      child: Image.asset('img/logo_amarela.png'),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          key: _formKeyLogin,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ///Verifica se é tela de cadastro ou login
                              !context
                                  .watch<LoginRegisterProvider>()
                                  .telaDeCadastro
                                  ? widgetDeLogin(context, _emailLoginController, _senhaLoginController, _formKeyLogin)
                                  : widgetCadastro(context, _nomeCadastroController, _emailCadastroController, _idadeCadastroController, _senhaCadastroController, _formKeyCadastroUsuario),

                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.orange.shade300,
                                  highlightColor: Colors.orange.shade100,
                                  hoverColor: Colors.orange.shade100,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      !context
                                          .watch<LoginRegisterProvider>()
                                          .telaDeCadastro ? 'Cadastra-se' : 'Login',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Provider.of<LoginRegisterProvider>(context, listen: false).AbrirOuFecharTelaDeCadastro();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///Componentes de Login do usuario
Widget widgetDeLogin(context, emailLoginController, senhaLoginController, formKeyLogin) {
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),

      ///Title "Login"
      Row(
        children: [
          Icon(
            Icons.lock,
            color: Theme
                .of(context)
                .primaryColorDark,
            size: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Login',
              style: TextStyle(fontSize: 20, color: Theme
                  .of(context)
                  .primaryColorDark),
            ),
          ),
        ],
      ),
      const SizedBox(height: 30),

      ///Text 'Email'
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '  E-mail',
          style: TextStyle(color: Theme
              .of(context)
              .primaryColorDark, fontSize: 16),
        ),
      ),
      const SizedBox(
        height: 5,
      ),

      ///TextField 'Email'
      TextFormField(
        obscureText: false,
        controller: emailLoginController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: Theme
                .of(context)
                .primaryColorDark,
          ),
          labelText: 'Informe seu E-mail',
        ),
        cursorColor: Colors.black54,
        keyboardType: TextInputType.emailAddress,
        validator: (text) {
          if (text!.isEmpty || !text.contains('@')) return "Informe um E-mail valido !";
        },
      ),
      const SizedBox(
        height: 20,
      ),

      ///Text 'Senha'
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '  Senha',
          style: TextStyle(color: Theme
              .of(context)
              .primaryColorDark, fontSize: 16),
        ),
      ),
      const SizedBox(
        height: 5,
      ),

      ///TextField 'Senha'
      TextFormField(
        obscureText: true,
        controller: senhaLoginController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelStyle: TextStyle(color: Theme
              .of(context)
              .primaryColorDark),
          labelText: 'Informe sua senha',
        ),
        cursorColor: Colors.black54,
        keyboardType: TextInputType.emailAddress,
        validator: (text) {
          if (text!.isEmpty) return "Informe uma senha valida !";
        },
      ),
      const SizedBox(
        height: 40,
      ),
      Container(
        alignment: Alignment.centerRight,
        //color: Colors.blue,
        child: InkWell(
          child: ElevatedButton(
            onPressed: () {
              if (formKeyLogin.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processo de Login iniciado')),
                );

                LoginUsuario(context, emailLoginController.text.toString(), senhaLoginController.text.toString());
              }
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Entrar',
                style: TextStyle(color: Theme
                    .of(context)
                    .primaryColorDark, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}


/// Componentes de Cadastro de usuario
Widget widgetCadastro(BuildContext context, TextEditingController nomeCadastroController, TextEditingController emailCadastroController, TextEditingController idadeCadastroController,
    TextEditingController senhaCadastroController, GlobalKey<FormState> formKeyCadastroUsuario) {
  return Form(
    key: formKeyCadastroUsuario,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.people_alt,
              color: Theme
                  .of(context)
                  .primaryColorDark,
              size: 28,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Cadastre-se',
                style: TextStyle(fontSize: 20, color: Theme
                    .of(context)
                    .primaryColorDark),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),

        Text(
          '  Informe um Nome',
          style: TextStyle(color: Theme
              .of(context)
              .primaryColorDark, fontSize: 16),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: false,
          controller: nomeCadastroController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColorDark,
            ),
            labelText: 'Nome',
          ),
          cursorColor: Colors.black54,
          keyboardType: TextInputType.emailAddress,
          validator: (text) {
            if (text!.isEmpty) return "Informe um nome !";
          },
        ),
        const SizedBox(
          height: 20,
        ),

        Text(
          '  Informe uma Idade',
          style: TextStyle(color: Theme
              .of(context)
              .primaryColorDark, fontSize: 16),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: false,
          controller: idadeCadastroController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColorDark,
            ),
            labelText: 'Idade',
          ),
          cursorColor: Colors.black54,
          keyboardType: TextInputType.emailAddress,
          validator: (text) {
            if (text!.isEmpty) return "Informe uma idade valido !";
          },
        ),
        const SizedBox(
          height: 20,
        ),

        Text(
          '  Informe um E-mail',
          style: TextStyle(color: Theme
              .of(context)
              .primaryColorDark, fontSize: 16),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: false,
          controller: emailCadastroController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColorDark,
            ),
            labelText: 'E-mail',
          ),
          cursorColor: Colors.black54,
          keyboardType: TextInputType.emailAddress,
          validator: (text) {
            if (text!.isEmpty || !text.contains('@')) return "Informe um E-mail valido !";
          },
        ),
        const SizedBox(
          height: 20,
        ),

        Text(
          '  Informe uma Senha',
          style: TextStyle(color: Theme
              .of(context)
              .primaryColorDark, fontSize: 16),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: true,
          controller: senhaCadastroController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColorDark,
            ),
            labelText: 'Senha',
          ),
          cursorColor: Colors.black54,
          keyboardType: TextInputType.emailAddress,
          validator: (text) {
            if (text!.isEmpty) return "Informe uma senha valida !";
          },
        ),
        const SizedBox(
          height: 20,
        ),

        Container(
          alignment: Alignment.centerRight,
          //color: Colors.blue,
          child: InkWell(
            child: ElevatedButton(

              onPressed: () {
                if (formKeyCadastroUsuario.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usuario cadastra')),
                  );

                  ///Cadastrando Usuario
                  CadastraUsuario(context, emailCadastroController.text, senhaCadastroController.text, nomeCadastroController.text, idadeCadastroController.text);
                }
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Cadastrar',
                  style: TextStyle(color: Theme
                      .of(context)
                      .primaryColorDark, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


///Cadastrando usuario
CadastraUsuario(BuildContext context, String email, String senha, String nome, String idade) async {
  await _auth.createUserWithEmailAndPassword(
      email: email, password: senha
  ).then((auth) {
    ///Identificando o id do usuario cadatrado para fazer o cadastro do demais dados do usuario como (nome completo e idade)
    String? idUsuario = auth.user?.uid;
    print('idUsuario $idUsuario');

    Usuario usuario = Usuario(
      auth.user?.uid ?? '',
      nome,
      auth.user?.email ?? '',
      idade,
    );

    GravaRestanteDosDadosDoUsuario(context, usuario);


  });
}
GravaRestanteDosDadosDoUsuario(BuildContext context, Usuario usuario) {
  final usuarioRef = _firebaseFirestore.collection('usuarios');
  usuarioRef.doc(usuario.idUsuario).set(usuario.toMap()).then((value){
    print('Entro no then !!!');
  }).then((value){
  });
}


LoginUsuario(BuildContext context, String email, String senha) async {
  await _auth.signInWithEmailAndPassword(email: email, password: senha).then((auth) {
    String? emailUsuario = auth.user?.uid;
  }).then((value){

    ///Navegando para tela de home page
    Navigator.pushReplacementNamed(context, "/home");
  });
}


