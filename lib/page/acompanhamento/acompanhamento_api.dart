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
import 'package:intl/intl.dart';

import 'acompanhamento.dart';
import 'categoria.dart';

class AcompanhamentoApi {
  static Future<Acompanhamento> getAcompanhamento(BuildContext context,Map<String,dynamic> value) async {
    final rotinas = List<Rotina>();
    User user =await User.get();

   /* var usdKey = Categoria.keys.firstWhere(
            (k) => Categoria[k] == value['gender'], orElse: () => null);*/

    var usdKey = Categoria[value['gender']];
    var ini = value['ini'];
    ini = new DateFormat('yyyy-MM-dd','pt').format(ini);
   var fim = value['fim'];
    fim = new DateFormat('yyyy-MM-dd','pt').format(fim);
    print(ini);
    print(fim);

    var url =
        'https://sistemas1.sefaz.ma.gov.br/gfis/services/conteudo/consultar/carga?tipo=$usdKey&dataInicial=$ini&dataFinal=$fim';


    print("url $url");
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
