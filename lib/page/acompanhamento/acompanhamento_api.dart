import 'dart:convert';
import 'dart:math';


import 'package:fisc/page/login/user.dart';
import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/utils/alert.dart';
import 'package:fisc/utils/nav.dart';
import 'package:fisc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fisc/utils/http_helper.dart' as http2;

import 'acompanhamento.dart';

class AcompanhamentoApi {
  static Future<Acompanhamento> getAcompanhamento(BuildContext context,int tipo, String dataIni, String dataFim) async {
    final rotinas = List<Rotina>();
    User user =await User.get();

    var url =
        'http://192.168.0.21:8082/sped-web/services/conteudo/consultar/carga?tipo=$tipo&dataInicial=$dataIni&dataFinal=$dataFim';



    if (await Utils.checkConnection()) {
    var response = await http2.get(url);

    if(response.statusCode==401 || response.statusCode==500 || response.statusCode==403) {
      User.clear();
      alert(context,"Sessão expirada!");
      alertLogin(context);
    }

    print('Response status: ${response.statusCode}');
    Map mapResponse = jsonDecode(response.body);
    print(mapResponse);
    final Acompanhamento acompanhamento = Acompanhamento.fromJson(mapResponse);
    print(acompanhamento);


    return acompanhamento;
  }else{
      alertConexao(context);
      return null;
    }
  }
}
