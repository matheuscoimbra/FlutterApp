import 'package:fisc/utils/prefs.dart';
import 'dart:convert' as convert;

class UsuarioResponse {
  User _user;
  String _error;

  UsuarioResponse({User user, String error}) {
    this._user = user;
    this._error = error;
  }

  User get user => _user;
  set user(User user) => _user = user;
  String get error => _error;
  set error(String error) => _error = error;

  UsuarioResponse.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    _error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    data['error'] = this._error;
    return data;
  }

  @override
  String toString() {
    return 'UsuarioResponse{_user: $_user, _error: $_error}';
  }


}

class User {
  String _login;
  String _senha;
  String _nome;
  List<String> _acessos;
  bool _ativarServico;
  bool _pararServico;
  bool _menuExecucao;
  bool _menuAcompanhamento;
  String _token;
  int _ultimoAcesso;

  User(
      {String login,
        String senha,
        String nome,
        List<String> acessos,
        bool ativarServico,
        bool pararServico,
        bool menuExecucao,
        bool menuAcompanhamento,
        String token,
        int ultimoAcesso}) {
    this._login = login;
    this._senha = senha;
    this._nome = nome;
    this._acessos = acessos;
    this._ativarServico = ativarServico;
    this._pararServico = pararServico;
    this._menuExecucao = menuExecucao;
    this._menuAcompanhamento = menuAcompanhamento;
    this._token = token;
    this._ultimoAcesso = ultimoAcesso;
  }

  String get login => _login;
  set login(String login) => _login = login;
  String get senha => _senha;
  set senha(String senha) => _senha = senha;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  List<String> get acessos => _acessos;
  set acessos(  List<String> acessos) => _acessos = acessos;
  bool get ativarServico => _ativarServico;
  set ativarServico(bool ativarServico) => _ativarServico = ativarServico;
  bool get pararServico => _pararServico;
  set pararServico(bool pararServico) => _pararServico = pararServico;
  bool get menuExecucao => _menuExecucao;
  set menuExecucao(bool menuExecucao) => _menuExecucao = menuExecucao;
  bool get menuAcompanhamento => _menuAcompanhamento;
  set menuAcompanhamento(bool menuAcompanhamento) =>
      _menuAcompanhamento = menuAcompanhamento;
  String get token => _token;
  set token(String token) => _token = token;
  int get ultimoAcesso => _ultimoAcesso;
  set ultimoAcesso(int ultimoAcesso) => _ultimoAcesso = ultimoAcesso;

  User.fromJson(Map<String, dynamic> json) {
    _login = json['login'];
    _senha = json['senha'];
    _nome = json['nome'];
    _acessos = json['acessos'];
    _ativarServico = json['ativarServico'];
    _pararServico = json['pararServico'];
    _menuExecucao = json['menuExecucao'];
    _menuAcompanhamento = json['menuAcompanhamento'];
    _token = json['token'];
    _ultimoAcesso = json['ultimoAcesso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this._login;
    data['senha'] = this._senha;
    data['nome'] = this._nome;
    data['acessos'] = this._acessos;
    data['ativarServico'] = this._ativarServico;
    data['pararServico'] = this._pararServico;
    data['menuExecucao'] = this._menuExecucao;
    data['menuAcompanhamento'] = this._menuAcompanhamento;
    data['token'] = this._token;
    data['ultimoAcesso'] = this._ultimoAcesso;
    return data;
  }

  void save(){
    Map map = toJson();
    String json =convert.json.encode(map);
        Prefs.setString("user.prefs", json);
  }

  static Future<User> get() async{
    String json = await Prefs.getString("user.prefs");
    if(json.isEmpty)
      return null;
    Map map = convert.json.decode(json);
    User user = User.fromJson(map);
    return user;
  }
  @override
  String toString() {
    return 'User{_login: $_login, _senha: $_senha, _nome: $_nome, _acessos: $_acessos, _ativarServico: $_ativarServico, _pararServico: $_pararServico, _menuExecucao: $_menuExecucao, _menuAcompanhamento: $_menuAcompanhamento, _token: $_token, _ultimoAcesso: $_ultimoAcesso}';
  }

  static void clear() {
    Prefs.setString("user.prefs", "");

  }


}