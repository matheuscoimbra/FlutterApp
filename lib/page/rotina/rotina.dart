import 'package:fisc/utils/event_bus.dart';

class RotinaEvent extends Event {


  String tipo;

  RotinaEvent( this.tipo);

  @override
  String toString() {
    return 'RotinaEvent{tipo: $tipo}';
  }
}



class Rotina {
  int _idProcessamento;
  String _dtFimProc;
  String _dtIniProc;
  int _qtdConteudos;
  String _tipoProcessamento;
  String _statusProcessamento;
  String _dtUltConteudoProc;
  int _nsuInicial;
  int _nsuFinal;
  int _quebrasIdentificadas;
  int _qtdErros;
  int _qtdVerificacoes;
  int _totalPaginas;
  int _pageNumber;
  int _pageSize;
  TipoConteudo _tipoConteudo;
  String _statusProcessamentoLabel;

  Rotina({int idProcessamento, String dtFimProc, String dtIniProc, int qtdConteudos, String tipoProcessamento, String statusProcessamento, String dtUltConteudoProc, int nsuInicial, int nsuFinal, int quebrasIdentificadas, int qtdErros, int qtdVerificacoes, int totalPaginas, int pageNumber, int pageSize, TipoConteudo tipoConteudo, String statusProcessamentoLabel}) {
    this._idProcessamento = idProcessamento;
    this._dtFimProc = dtFimProc;
    this._dtIniProc = dtIniProc;
    this._qtdConteudos = qtdConteudos;
    this._tipoProcessamento = tipoProcessamento;
    this._statusProcessamento = statusProcessamento;
    this._dtUltConteudoProc = dtUltConteudoProc;
    this._nsuInicial = nsuInicial;
    this._nsuFinal = nsuFinal;
    this._quebrasIdentificadas = quebrasIdentificadas;
    this._qtdErros = qtdErros;
    this._qtdVerificacoes = qtdVerificacoes;
    this._totalPaginas = totalPaginas;
    this._pageNumber = pageNumber;
    this._pageSize = pageSize;
    this._tipoConteudo = tipoConteudo;
    this._statusProcessamentoLabel = statusProcessamentoLabel;
  }

  int get idProcessamento => _idProcessamento;
  set idProcessamento(int idProcessamento) => _idProcessamento = idProcessamento;
  String get dtFimProc => _dtFimProc;
  set dtFimProc(String dtFimProc) => _dtFimProc = dtFimProc;
  String get dtIniProc => _dtIniProc;
  set dtIniProc(String dtIniProc) => _dtIniProc = dtIniProc;
  int get qtdConteudos => _qtdConteudos;
  set qtdConteudos(int qtdConteudos) => _qtdConteudos = qtdConteudos;
  String get tipoProcessamento => _tipoProcessamento;
  set tipoProcessamento(String tipoProcessamento) => _tipoProcessamento = tipoProcessamento;
  String get statusProcessamento => _statusProcessamento;
  set statusProcessamento(String statusProcessamento) => _statusProcessamento = statusProcessamento;
  String get dtUltConteudoProc => _dtUltConteudoProc;
  set dtUltConteudoProc(String dtUltConteudoProc) => _dtUltConteudoProc = dtUltConteudoProc;
  int get nsuInicial => _nsuInicial;
  set nsuInicial(int nsuInicial) => _nsuInicial = nsuInicial;
  int get nsuFinal => _nsuFinal;
  set nsuFinal(int nsuFinal) => _nsuFinal = nsuFinal;
  int get quebrasIdentificadas => _quebrasIdentificadas;
  set quebrasIdentificadas(int quebrasIdentificadas) => _quebrasIdentificadas = quebrasIdentificadas;
  int get qtdErros => _qtdErros;
  set qtdErros(int qtdErros) => _qtdErros = qtdErros;
  int get qtdVerificacoes => _qtdVerificacoes;
  set qtdVerificacoes(int qtdVerificacoes) => _qtdVerificacoes = qtdVerificacoes;
  int get totalPaginas => _totalPaginas;
  set totalPaginas(int totalPaginas) => _totalPaginas = totalPaginas;
  int get pageNumber => _pageNumber;
  set pageNumber(int pageNumber) => _pageNumber = pageNumber;
  int get pageSize => _pageSize;
  set pageSize(int pageSize) => _pageSize = pageSize;
  TipoConteudo get tipoConteudo => _tipoConteudo;
  set tipoConteudo(TipoConteudo tipoConteudo) => _tipoConteudo = tipoConteudo;
  String get statusProcessamentoLabel => _statusProcessamentoLabel;
  set statusProcessamentoLabel(String statusProcessamentoLabel) => _statusProcessamentoLabel = statusProcessamentoLabel;

  Rotina.fromJson(Map<String, dynamic> json) {
    _idProcessamento = json['idProcessamento'];
    _dtFimProc = json['dtFimProc'];
    _dtIniProc = json['dtIniProc'];
    _qtdConteudos = json['qtdConteudos'];
    _tipoProcessamento = json['tipoProcessamento'];
    _statusProcessamento = json['statusProcessamento'];
    _dtUltConteudoProc = json['dtUltConteudoProc'];
    _nsuInicial = json['nsuInicial'];
    _nsuFinal = json['nsuFinal'];
    _quebrasIdentificadas = json['quebrasIdentificadas'];
    _qtdErros = json['qtdErros'];
    _qtdVerificacoes = json['qtdVerificacoes'];
    _totalPaginas = json['totalPaginas'];
    _pageNumber = json['pageNumber'];
    _pageSize = json['pageSize'];
    _tipoConteudo = json['tipoConteudo'] != null ? new TipoConteudo.fromJson(json['tipoConteudo']) : null;
    _statusProcessamentoLabel = json['statusProcessamentoLabel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProcessamento'] = this._idProcessamento;
    data['dtFimProc'] = this._dtFimProc;
    data['dtIniProc'] = this._dtIniProc;
    data['qtdConteudos'] = this._qtdConteudos;
    data['tipoProcessamento'] = this._tipoProcessamento;
    data['statusProcessamento'] = this._statusProcessamento;
    data['dtUltConteudoProc'] = this._dtUltConteudoProc;
    data['nsuInicial'] = this._nsuInicial;
    data['nsuFinal'] = this._nsuFinal;
    data['quebrasIdentificadas'] = this._quebrasIdentificadas;
    data['qtdErros'] = this._qtdErros;
    data['qtdVerificacoes'] = this._qtdVerificacoes;
    data['totalPaginas'] = this._totalPaginas;
    data['pageNumber'] = this._pageNumber;
    data['pageSize'] = this._pageSize;
    if (this._tipoConteudo != null) {
      data['tipoConteudo'] = this._tipoConteudo.toJson();
    }
    data['statusProcessamentoLabel'] = this._statusProcessamentoLabel;
    return data;
  }

  @override
  String toString() {
    return 'Rotina{_idProcessamento: $_idProcessamento, _dtFimProc: $_dtFimProc, _dtIniProc: $_dtIniProc, _qtdConteudos: $_qtdConteudos, _tipoProcessamento: $_tipoProcessamento, _statusProcessamento: $_statusProcessamento, _dtUltConteudoProc: $_dtUltConteudoProc, _nsuInicial: $_nsuInicial, _nsuFinal: $_nsuFinal, _quebrasIdentificadas: $_quebrasIdentificadas, _qtdErros: $_qtdErros, _qtdVerificacoes: $_qtdVerificacoes, _totalPaginas: $_totalPaginas, _pageNumber: $_pageNumber, _pageSize: $_pageSize, _tipoConteudo: $_tipoConteudo, _statusProcessamentoLabel: $_statusProcessamentoLabel}';
  }


}

class TipoConteudo {
  int _idTipoConteudo;
  String _categoria;
  String _controle;
  String _categoriaDescricao;

  TipoConteudo({int idTipoConteudo, String categoria, String controle, String categoriaDescricao}) {
    this._idTipoConteudo = idTipoConteudo;
    this._categoria = categoria;
    this._controle = controle;
    this._categoriaDescricao = categoriaDescricao;
  }

  int get idTipoConteudo => _idTipoConteudo;
  set idTipoConteudo(int idTipoConteudo) => _idTipoConteudo = idTipoConteudo;
  String get categoria => _categoria;
  set categoria(String categoria) => _categoria = categoria;
  String get controle => _controle;
  set controle(String controle) => _controle = controle;
  String get categoriaDescricao => _categoriaDescricao;
  set categoriaDescricao(String categoriaDescricao) => _categoriaDescricao = categoriaDescricao;

  TipoConteudo.fromJson(Map<String, dynamic> json) {
    _idTipoConteudo = json['idTipoConteudo'];
    _categoria = json['categoria'];
    _controle = json['controle'];
    _categoriaDescricao = json['categoriaDescricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTipoConteudo'] = this._idTipoConteudo;
    data['categoria'] = this._categoria;
    data['controle'] = this._controle;
    data['categoriaDescricao'] = this._categoriaDescricao;
    return data;
  }

  @override
  String toString() {
    return 'TipoConteudo{_idTipoConteudo: $_idTipoConteudo, _categoria: $_categoria, _controle: $_controle, _categoriaDescricao: $_categoriaDescricao}';
  }


}