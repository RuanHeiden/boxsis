class Produto {
  String? uid;
  String nomeProduto;
  String codigoRef;
  String quantidade;
  String grupo;
  String marca;
  String distribuidor;
  String unidadeMedida;
  String peso;
  String dataValidade;
  String dataEntrada;
  String valorCompra;

  Produto(
    this.uid,
    this.nomeProduto,
    this.codigoRef,
    this.quantidade,
    this.grupo,
    this.marca,
    this.distribuidor,
    this.unidadeMedida,
    this.peso,
    this.dataValidade,
    this.dataEntrada,
    this.valorCompra
  );

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "uid" : uid,
      "nomeProduto" : nomeProduto,
      "codigoRef" : codigoRef,
      "quantidade" : quantidade,
      "grupo" : grupo,
      "marca" : marca,
      "distribuidor" : distribuidor,
      "unidadeMedida" : unidadeMedida,
      "peso" : peso,
      "dataValidade" : dataValidade,
      "dataEntrada" : dataEntrada,
      "valorCompra" : valorCompra,
    };
    return map;
  }

}