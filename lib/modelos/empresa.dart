class Empresa{
    String? uid;
    String nomeEmpresa;
    String nomeFantasia;
    String descricao;
    String cnpj;
    String telefone;
    String segmento;
    String endereco;

    Empresa(
        this.uid,
        this.nomeEmpresa,
        this.nomeFantasia,
        this.descricao,
        this.cnpj,
        this.telefone,
        this.segmento,
        this.endereco,
        );

    Map<String, dynamic> toMap(){
      Map<String, dynamic> map = {
        "uid" : uid, "nomeEmpresa" : nomeEmpresa,
        "nomeFantasia" : nomeFantasia, "descricao" : descricao,
        "cnpj" : cnpj, "telefone" : telefone, "segmento" : segmento, "endereco" : endereco,
      };
      return map;
    }
}