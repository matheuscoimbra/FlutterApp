import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisc/page/api_response.dart';
import 'package:fisc/page/home/initial_page.dart';
import 'package:fisc/page/rotina/home_page.dart';
import 'package:fisc/page/login/login_api.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/utils/alert.dart';
import 'package:fisc/utils/finger_print.dart';
import 'package:fisc/utils/nav.dart';
import 'package:fisc/utils/service_locator.dart';
import 'package:fisc/widgets/app_button.dart';
import 'package:fisc/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _streamControler = StreamController<bool>();

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _bloc = LoginBloc();
  User _user;

  final FingerPrint _localAuth = locator<FingerPrint>();

  @override
  void initState() {
    super.initState();
    Future<User> future = User.get();
    future.then((User usuario) {
      _user = usuario;
      if (usuario != null) {
        // push(context, Home(),replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: loginBody(),
      ),
    );
  }

  loginBody() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields()],
        ),
      );

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CachedNetworkImage(
              imageUrl: "https://www.policiacivil.ma.gov.br/wp-content/uploads/2017/04/logo-governoma-2015.png", fit: BoxFit.contain,),

          Text(
            "Bem-vindo ao GFIS",
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Entre com suas credenciais",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  loginFields() => Form(
        key: _formKey,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                child: TextFormField(
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
                  controller: _tLogin,
                  validator: (String text) {
                    if (text.isEmpty) {
                      return "Digite o login";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String text) {
                    if (_focusSenha != null) {
                      FocusScope.of(context).requestFocus(_focusSenha);
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Usuário',
                      prefixIcon: Icon(Icons.person_outline),
                      labelStyle: TextStyle(fontSize: 15)),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: TextFormField(
                  obscureText: true,
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
                  controller: _tSenha,
                  validator: (String text) {
                    if (text.isEmpty) {
                      return "Digite a senha";
                    }
                    if (text.length < 5) {
                      return "Senha precisa ter pelo menos 5 digitos";
                    }
                    return null;
                  },
                  focusNode: _focusSenha,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock_outline),
                      labelStyle: TextStyle(fontSize: 15)),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              StreamBuilder<bool>(
                  stream: _bloc.progress.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                      width: double.infinity,
                      child: RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        shape: StadiumBorder(),
                        child: snapshot.data? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ): Text('LOGIN',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: 'SFUIDisplay',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Colors.green,
                        onPressed: _onClickLogin,
                      ),
                    );


                  }),

              SizedBox(
                height: 5.0,
              ),

            ],
          ),
        ),
      );

  void _onClickFiger(BuildContext context) async {
    final ok = _localAuth.authenticate;

    push(context, Home(), replace: true);
  }

  void _onClickLogin() async {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    _streamControler.add(true);

    ApiResponse response = await await _bloc.login(login, senha);

    if (response.ok) {
      UsuarioResponse user = response.result;
      push(context, Home(), replace: true);
    } else {
      alert(context, response.msg);
    }
    _streamControler.add(false);
  }

  String _validaSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 5) {
      return "Senha precisa ter pelo menos 5 digitos";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
