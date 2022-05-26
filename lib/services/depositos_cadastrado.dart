import 'package:boxsis/modelos/deposito.dart';
import 'package:boxsis/services/firebase/deposito_firestore.dart';
import 'package:flutter/cupertino.dart';

Future<List<Deposito>> BuscaDepositoCadastrado(BuildContext context) async {
  var listaDeposito = await getDeposito(context);

  List<Deposito> _depositos = [];
  for (int i = 0; i < listaDeposito.length; i++) {
    var depositoUnidade = listaDeposito[i];
    Deposito deposito = Deposito(
      depositoUnidade['uid'] ?? '',
      depositoUnidade['nomeDeposito'] ?? '',
      depositoUnidade['descricao'] ?? '',
      depositoUnidade['telefone'] ?? '',
      depositoUnidade['segmento'] ?? '',
      depositoUnidade['endereco'] ?? ''
    );
    _depositos.add(deposito);
  }
  return _depositos;
}
