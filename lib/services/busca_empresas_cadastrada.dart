import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/services/firebase/empresa_firestore.dart';

///Chama o getEmpresa para buscar a lista de empresas cadatradas no firebase
///E trasforma em uma lista de empresas
Future<List<Empresa>> BuscaEmpresaCadastrada() async{

  var jsonEmpresas = await getEmpresa();
  List<Empresa> empresas = [];

  for(int i = 0; i < jsonEmpresas.docs.length; i++){
    var empresaUnidade = jsonEmpresas.docs[i].data();
    Empresa empresa = Empresa(
        empresaUnidade['uid'] ?? '',
        empresaUnidade['nomeEmpresa'] ?? '',
        empresaUnidade['nomeFantasia'] ?? '',
        empresaUnidade['descricao'] ?? '',
        empresaUnidade['cnpj'] ?? '',
        empresaUnidade['telefone'] ?? '',
        empresaUnidade['segmento'] ?? '',
        empresaUnidade['endereco'] ?? '',
        empresaUnidade['numeroFuncionario'] ?? ''
    );
    empresas.add(empresa);
    print('empresa ${empresa.uid}');
  }
  return empresas;
}