

import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {

  final _formKeyCadastroUsuario = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var MediaHeight = MediaQuery.of(context).size.height;
    var MediaWeigth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MediaWeigth < 800 ? Theme.of(context).primaryColorLight : Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(

            width: MediaWeigth > 1050 ? 450
                : MediaWeigth < 800 ? MediaWeigth
                : MediaWeigth / 2,
            height: MediaWeigth > 1050 ? 550 : MediaHeight,
            decoration: BoxDecoration(
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Colors.black45,
                      blurRadius: 15.0,
                      offset: Offset(5.9, 5.75)
                  )
                ],
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                )),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: _formKeyCadastroUsuario,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children:   [
                                Icon(
                                  Icons.people_alt,
                                  color: Theme.of(context).primaryColorDark,
                                  size: 28,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Cadastre-se',
                                    style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),

                            Text(
                              '  Informe um Nome',
                              style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              obscureText: false,
                              controller: _nomeController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
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
                              style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              obscureText: false,
                              controller: _idadeController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
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
                              style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              obscureText: false,
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
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
                              style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              obscureText: false,
                              controller: _senhaController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
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
                                    if (_formKeyCadastroUsuario.currentState!.validate()) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Usuario cadastra')),
                                      );

                                      print('teste');
                                    }
                                  },
                                  child:  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Entrar',
                                      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 18),
                                    ),
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
