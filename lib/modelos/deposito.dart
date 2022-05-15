
class Deposito{
  String? uid;
  String nomeEmpresa;
  String descricao;
  String telefone;
  String segmento;
  String endereco;

  Deposito(
      this.uid,
      this.nomeEmpresa,
      this.descricao,
      this.telefone,
      this.segmento,
      this.endereco,
      );

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "uid" : uid,
      "nomeEmpresa" : nomeEmpresa,
      "descricao" : descricao,
      "telefone" : telefone,
      "segmento" : segmento,
      "endereco" : endereco,
    };
    return map;
  }
}