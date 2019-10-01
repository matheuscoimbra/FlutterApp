import 'dart:convert';
import 'dart:math';

import 'package:fisc/page/api_response.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/utils/alert.dart';
import 'package:fisc/utils/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class RotinaApiAtivar {
 static Future<String> ativar(String ativarPara, int idTipoConteudo, String tipo, BuildContext context, [String tipoRotina]) async {

    User user =await User.get();
    var url =
        'services/rotina/$ativarPara/$idTipoConteudo/$tipo';

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":"Bearer ${user.token}"
    };

    print(url);

    var response = await http.get(url,
        headers: headers
       );


    if(response.statusCode==200){
      EventBus.get(context).sendEvent(RotinaEvent(tipoRotina));

    }

    print('Response status: ${response.statusCode}');
    if(response.statusCode==401 || response.statusCode==500 || response.statusCode==403) {
      User.clear();
      alert(context,"Sessão expirada!");
      alertLogin(context);
    }

    String result =  response.body;
    print(result);

    return result;
 }
}
