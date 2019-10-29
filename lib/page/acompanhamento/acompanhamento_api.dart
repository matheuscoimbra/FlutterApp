import 'dart:convert';
import 'dart:math';

import 'package:fisc/page/api_response.dart';
import 'package:fisc/page/login/login_page.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/utils/alert.dart';
import 'package:fisc/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fisc/utils/http_helper.dart' as http2;

import 'acompanhamento.dart';

class AcompanhamentoApi {
  static Future<Acompanhamento> getAcompanhamento(BuildContext context) async {
    final rotinas = List<Rotina>();
    User user =await User.get();

    var url =
        'http://192.168.0.3:8082/sped-web/services/conteudo/consultar/carga?tipo=13&dataInicial=2019-03-12&dataFinal=2019-03-14';




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
  }
}
