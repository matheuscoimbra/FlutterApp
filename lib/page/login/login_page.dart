
import 'dart:async';

import 'package:fisc/page/api_response.dart';
import 'package:fisc/page/home/initial_page.dart';
import 'package:fisc/page/rotina/home_page.dart';
import 'package:fisc/page/login/login_api.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/utils/alert.dart';
import 'package:fisc/utils/nav.dart';
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

  final _streamControler =  StreamController<bool>();


  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _bloc = LoginBloc();


  final LocalAuthentication _localAuth = LocalAuthentication();


  @override
  void initState() {
    super.initState();
    Future<User> future = User.get();
    future.then((User usuario){
      if(usuario!=null){
        push(context, Home(),replace: true);
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sistema"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() { return Form(
    key: _formKey,
    child: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage( "https://www.policiacivil.ma.gov.br/wp-content/uploads/2017/04/logo-governoma-2015.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter
              )
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 270),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SFUIDisplay'
                      ),
                      controller: _tLogin,
                      validator: (String text){
                        if(text.isEmpty){
                          return "Digite o login";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String text) {
                        if ( _focusSenha != null) {
                          FocusScope.of(context).requestFocus(_focusSenha);
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Usuário',
                          prefixIcon: Icon(Icons.person_outline),
                          labelStyle: TextStyle(
                              fontSize: 15
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFUIDisplay'
                    ),
                    controller: _tSenha,
                    validator: (String text){
                      if(text.isEmpty){
                        return "Digite a senha";
                      }
                      if(text.length<5){
                        return "Senha precisa ter pelo menos 5 digitos";
                      }
                      return null;
                    },
                    focusNode: _focusSenha,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.lock_outline),
                        labelStyle: TextStyle(
                            fontSize: 15
                        )
                    ),
                  ),
                ),
                StreamBuilder<bool>(
                  stream:_bloc.progress.stream,
                  initialData: false,
                  builder: (context,snapshot){
                    return  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: MaterialButton(
                        onPressed: _onClickLogin,//
                        // since this is only a UI app
                        child:snapshot.data? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ): Text('LOGIN',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SFUIDisplay',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Color(0xffff2d55),
                        elevation: 0,
                        minWidth: 400,
                        height: 50,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    );
                  },
                ),


              ],
            ),
          ),
        )
      ],
    ),
  );

  }



  void _onClickLogin() async{

     bool formOk = _formKey.currentState.validate();
    if(!formOk){
      return;
    }

    String login =  _tLogin.text;
    String senha =_tSenha.text;

   _streamControler.add(true);

    ApiResponse response = await await _bloc.login(login, senha);

    if(response.ok){
      UsuarioResponse user = response.result;
      push(context,Home(),replace: true);
    }else{
      alert(context,response.msg);
    }
    _streamControler.add(false);


  }


  String _validaSenha(String text){
      if(text.isEmpty){
        return "Digite a senha";
      }
      if(text.length<5){
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
