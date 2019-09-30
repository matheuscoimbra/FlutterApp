import 'package:fisc/utils/prefs.dart';
import 'dart:convert' as convert;

class UsuarioResponse {
  User _user;

  UsuarioResponse({User user}) {
    this._user = user;
  }

  User get user => _user;

  set user(User user) => _user = user;

  UsuarioResponse.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'UsuarioResponse{_user: $_user}';
  }
}

class User {
  String _login;
  String _nome;
  bool _ativarServico;
  bool _pararServico;
  bool _menuExecucao;
  bool _menuAcompanhamento;
  String _token;
  String _ultimoAcesso;

  User(
      {String login,
      String nome,
      bool ativarServico,
      bool pararServico,
      bool menuExecucao,
      bool menuAcompanhamento,
      String token,
      String ultimoAcesso}) {
    this._login = login;
    this._nome = nome;
    this._ativarServico = ativarServico;
    this._pararServico = pararServico;
    this._menuExecucao = menuExecucao;
    this._menuAcompanhamento = menuAcompanhamento;
    this._token = token;
    this._ultimoAcesso = ultimoAcesso;
  }

  String get login => _login;

  set login(String login) => _login = login;

  String get nome => _nome;

  set nome(String nome) => _nome = nome;

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

  String get ultimoAcesso => _ultimoAcesso;

  set ultimoAcesso(String ultimoAcesso) => _ultimoAcesso = ultimoAcesso;

  User.fromJson(Map<String, dynamic> json) {
    _login = json['login'];
    _nome = json['nome'];
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
    data['nome'] = this._nome;
    data['ativarServico'] = this._ativarServico;
    data['pararServico'] = this._pararServico;
    data['menuExecucao'] = this._menuExecucao;
    data['menuAcompanhamento'] = this._menuAcompanhamento;
    data['token'] = this._token;
    data['ultimoAcesso'] = this._ultimoAcesso;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("user.prefs", json);
  }

  static Future<User> get() async {
    String json = await Prefs.getString("user.prefs");
    if (json.isEmpty) return null;
    Map map = convert.json.decode(json);
    User user = User.fromJson(map);
    return user;
  }


  @override
  String toString() {
    return 'User{_login: $_login, _nome: $_nome, _ativarServico: $_ativarServico, _pararServico: $_pararServico, _menuExecucao: $_menuExecucao, _menuAcompanhamento: $_menuAcompanhamento, _token: $_token, _ultimoAcesso: $_ultimoAcesso}';
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }
}
