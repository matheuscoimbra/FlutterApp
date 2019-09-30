
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
  bool _showProgress = false;


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

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
         children: <Widget>[
           SizedBox(
             width: 160,
             height: 160,
             child: Image.network( "https://media.licdn.com/dms/image/C4E0BAQEz2vTBRFh6Qw/company-logo_200_200/0?e=2159024400&v=beta&t=eet2EKr0GEwEujtH4YeQDNIvFwgfnJOmSfh73m4zXlY"),
           ),
           SizedBox(
             height: 20,
           ),
           AppText("Login", "Digite o login", controller: _tLogin, validator: (String text){
            if(text.isEmpty){
              return "Digite o login";
            }
            return null;
          }, textInputAction: TextInputAction.next,nextNode: _focusSenha),
           SizedBox(
             height: 10,
           ),
           AppText("Senha","Digite a senha", password: true, controller: _tSenha, validator: _validaSenha,focusNode: _focusSenha),
           SizedBox(
             height: 10,
           ),
           StreamBuilder<bool>(
             stream: _streamControler.stream,
             builder: (context,snapshot){
                return AppButton("Login", onPressed: _onClickLogin, showProgress: snapshot.data!=null?snapshot.data:false,);
             },
           ),



         ],
        ),
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

    ApiResponse response = await LoginApi.login(login, senha);

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
    // TODO: implement dispose
    super.dispose();
    _streamControler.close();
  }
}
