class Deposito{
  String? uid;
  String nomeDeposito;
  String descricao;
  String telefone;
  String segmento;
  String endereco;
  Deposito(
      this.uid,
      this.nomeDeposito,
      this.descricao,
      this.telefone,
      this.segmento,
      this.endereco,
      );
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "uid" : uid, "nomeDeposito" : nomeDeposito,
      "descricao" : descricao, "telefone" : telefone,
      "segmento" : segmento, "endereco" : endereco,
    };
    return map;
  }
}