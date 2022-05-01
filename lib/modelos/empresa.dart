
class Empresa{
    String nomeEmpresa;
    String nomeFantasia;
    String descricao;
    String cnpj;
    String telefone;
    String segmento;
    String endereco;
    String numeroFuncionario;

    Empresa(
        this.nomeEmpresa,
        this.nomeFantasia,
        this.descricao,
        this.cnpj,
        this.telefone,
        this.segmento,
        this.endereco,
        this.numeroFuncionario
        );

    Map<String, dynamic> toMap(){
      Map<String, dynamic> map = {
        "nomeEmpresa" : nomeEmpresa,
        "nomeFantasia" : nomeFantasia,
        "descricao" : descricao,
        "cnpj" : cnpj,
        "telefone" : telefone,
        "segmento" : segmento,
        "numeroFuncionario" : numeroFuncionario,
      };
      return map;
    }
}