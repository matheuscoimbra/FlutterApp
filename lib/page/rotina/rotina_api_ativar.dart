import 'dart:convert';
import 'dart:math';

import 'package:fisc/page/api_response.dart';
import 'package:fisc/page/home/initial_page.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/utils/alert.dart';
import 'package:fisc/utils/event_bus.dart';
import 'package:fisc/utils/nav.dart';
import 'package:fisc/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class RotinaApiAtivar {
 static Future<String> ativar(String ativarPara, int idTipoConteudo, String tipo, BuildContext context, [String tipoRotina]) async {

    User user =await User.get();
    var url =
        'https://sistemas1.sefaz.ma.gov.br/gfis/services/rotina/$ativarPara/$idTipoConteudo/$tipo';
    print("url -> ${url}");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":"Bearer ${user.token}"
    };

    print(url);
    if (await Utils.checkConnection()) {
    var response = await http.get(url,
        headers: headers
       );


    if(response.statusCode==200){

      await Future.delayed(Duration(seconds: 4));
      EventBus.get(context).sendEvent(RotinaEvent(tipoRotina));

    }

    print('Response status: ${response.statusCode}');
    if(response.statusCode==401 ) {
      User.clear();
      alert(context,"Sessão expirada!");
      alertLogin(context);
    }
    if( response.statusCode==403){
      alert(context,"Acesso negado!");
    }
    if(response.statusCode==500){

     // alert(context,"Erro inesperado!");
      //alertHome(context);
      print("{\"message\":\"Error Inesperado\"}");
      return "{\"message\":\"Error Inesperado\"}";
    }

    String result =  response.body;
    print(result);

    return result;
 }else{
      alertConexao(context);
      return null;
    }
 }
}
