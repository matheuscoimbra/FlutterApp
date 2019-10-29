class Acompanhamento {
  Hst hst;
  Carga carga;

  Acompanhamento({this.hst, this.carga});

  Acompanhamento.fromJson(Map<String, dynamic> json) {
    hst = json['hst'] != null ? new Hst.fromJson(json['hst']) : null;
    carga = json['carga'] != null ? new Carga.fromJson(json['carga']) : null;
  }



  @override
  String toString() {
    return 'Acompanhamento{hst: $hst, carga: $carga}';
  }

}

class Hst {
  Map<String,List<Historico>> historico= new Map<String, List<Historico>>();
  List<Historico> list = new List<Historico>();
  Hst({this.historico});

  Hst.fromJson(Map<dynamic, dynamic> json) {
    
    json.forEach((key, value) => print('Key: $key, Value: $value'));
    print('teste');
    json.forEach((key, value) {

          list = new List<Historico>();
          json[key].forEach((v) {
            list.add(Historico.fromJson(v));

          });
          historico[key]=list;

    });

    historico.forEach((key, value) => print('Key: $key, Value: $value'));

  }



  @override
  String toString() {
    return 'Hst{historico: $historico}';
  }

}

class Historico {
  String nome;
  String descricao;
  String estilo;
  int idTipo;
  String data;

  Historico({this.nome, this.descricao, this.estilo, this.idTipo, this.data});

  Historico.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    descricao = json['descricao'];
    estilo = json['estilo'];
    idTipo = json['idTipo'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['estilo'] = this.estilo;
    data['idTipo'] = this.idTipo;
    data['data'] = this.data;
    return data;
  }

  @override
  String toString() {
    return 'Historico{nome: $nome, descricao: $descricao, estilo: $estilo, idTipo: $idTipo, data: $data}';
  }


}

class Carga {
  int qtdTotal;
  int qtdLac;
  int qtdBaix;
  int qtdBaixPr;
  int qtdBaixPrAn;
  int qtdBaixPrNa;
  int qtdBaixNp;
  int qtdErr;

  Carga(
      {this.qtdTotal,
        this.qtdLac,
        this.qtdBaix,
        this.qtdBaixPr,
        this.qtdBaixPrAn,
        this.qtdBaixPrNa,
        this.qtdBaixNp,
        this.qtdErr});

  Carga.fromJson(Map<String, dynamic> json) {
    qtdTotal = json['qtdTotal'];
    qtdLac = json['qtdLac'];
    qtdBaix = json['qtdBaix'];
    qtdBaixPr = json['qtdBaixPr'];
    qtdBaixPrAn = json['qtdBaixPrAn'];
    qtdBaixPrNa = json['qtdBaixPrNa'];
    qtdBaixNp = json['qtdBaixNp'];
    qtdErr = json['qtdErr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qtdTotal'] = this.qtdTotal;
    data['qtdLac'] = this.qtdLac;
    data['qtdBaix'] = this.qtdBaix;
    data['qtdBaixPr'] = this.qtdBaixPr;
    data['qtdBaixPrAn'] = this.qtdBaixPrAn;
    data['qtdBaixPrNa'] = this.qtdBaixPrNa;
    data['qtdBaixNp'] = this.qtdBaixNp;
    data['qtdErr'] = this.qtdErr;
    return data;
  }

  @override
  String toString() {
    return 'Carga{qtdTotal: $qtdTotal, qtdLac: $qtdLac, qtdBaix: $qtdBaix, qtdBaixPr: $qtdBaixPr, qtdBaixPrAn: $qtdBaixPrAn, qtdBaixPrNa: $qtdBaixPrNa, qtdBaixNp: $qtdBaixNp, qtdErr: $qtdErr}';
  }


}