part of swagger.api;

class TipoConteudo {
  
  int idTipoConteudo = null;
  

  String categoria = null;
  //enum categoriaEnum {  NENHUM,  NFE,  CTE,  MDFE,  NFCE,  EFD,  CTEOS,  DIEF,  GIA_ST,  CONV_115,  BPE,  PGDASD,  TEF,  DEFIS,  NFE_EVENTO,  CTE_EVENTO,  MDFE_EVENTO,  NFCE_EVENTO,  EFD_OIE,  SCANC,  DI,  CCC,  DESTDA,  };

  String grupo = null;
  //enum grupoEnum {  NENHUM,  DOCUMENTO,  DECLARACAO,  };

  String controle = null;
  //enum controleEnum {  NENHUM,  COMPLETO,  LACUNA,  MONITORAMENTO,  };

  String categoriaDescricao = null;
  
  TipoConteudo();

  @override
  String toString() {
    return 'TipoConteudo[idTipoConteudo=$idTipoConteudo, categoria=$categoria, grupo=$grupo, controle=$controle, categoriaDescricao=$categoriaDescricao, ]';
  }

  TipoConteudo.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    idTipoConteudo =
        json['idTipoConteudo']
    ;
    categoria =
        json['categoria']
    ;
    grupo =
        json['grupo']
    ;
    controle =
        json['controle']
    ;
    categoriaDescricao =
        json['categoriaDescricao']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'idTipoConteudo': idTipoConteudo,
      'categoria': categoria,
      'grupo': grupo,
      'controle': controle,
      'categoriaDescricao': categoriaDescricao
     };
  }

  static List<TipoConteudo> listFromJson(List<dynamic> json) {
    return json == null ? new List<TipoConteudo>() : json.map((value) => new TipoConteudo.fromJson(value)).toList();
  }

  static Map<String, TipoConteudo> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, TipoConteudo>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new TipoConteudo.fromJson(value));
    }
    return map;
  }
}

