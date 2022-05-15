import 'package:boxsis/modelos/empresa.dart';
import 'package:boxsis/services/firebase/empresa_firestore.dart';

///Chama o getEmpresa para buscar a lista de empresas cadatradas no firebase
///E trasforma em uma lista de empresas
Future<List<Empresa>> BuscaEmpresaCadastrada() async{

  var listaEmpresas = await getEmpresa();
  List<Empresa> empresas = [];
  for(int i = 0; i < listaEmpresas.length; i++){
    var empresaUnidade = listaEmpresas[i];
    Empresa empresa = Empresa(
        empresaUnidade['uid'] ?? '',
        empresaUnidade['nomeEmpresa'] ?? '',
        empresaUnidade['nomeFantasia'] ?? '',
        empresaUnidade['descricao'] ?? '',
        empresaUnidade['cnpj'] ?? '',
        empresaUnidade['telefone'] ?? '',
        empresaUnidade['segmento'] ?? '',
        empresaUnidade['endereco'] ?? '',
    );
    empresas.add(empresa);
  }
  return empresas;
}

