import 'dart:convert';
import 'dart:math';

import 'package:fisc/page/api_response.dart';
import 'package:fisc/page/login/login_page.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/utils/alert.dart';
import 'package:fisc/utils/nav.dart';
import 'package:fisc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fisc/utils/http_helper.dart' as http2;

class RotinaApi {
 static Future<List<Rotina>> getRotinas(BuildContext context, String tipoRotina) async {
    final rotinas = List<Rotina>();
    User user =await User.get();

    var url =
        'http://192.168.:8082/sped-web/services/rotina/$tipoRotina';

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":"Bearer ${user.token}"
    };

    print(url);
    if (await Utils.checkConnection()) {
      var response = await http2.get(url);

      if (response.statusCode == 401) {
        User.clear();
        alert(context, "Sessão expirada!");
        alertLogin(context);
      }
      if (response.statusCode == 403) {
        alert(context, "Acesso negado!");
      }
      if (response.statusCode == 500) {
        alert(context, "Erro inesperado!");
        alertHome(context);
      }

      print('Response status: ${response.statusCode}');
      Map mapResponse = jsonDecode(response.body);
      mapResponse.forEach((k, v) => rotinas.add(Rotina.fromJson(v)));

      rotinas.forEach((f) => print(f.tipoConteudo.categoria));

      return rotinas;
    }else{
      alertConexao(context);
      return null;
    }
 }
}
