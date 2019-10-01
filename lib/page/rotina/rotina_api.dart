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

class RotinaApi {
 static Future<List<Rotina>> getRotinas(BuildContext context, String tipoRotina) async {
    final rotinas = List<Rotina>();
    User user =await User.get();

    var url =
        'services/rotina/$tipoRotina';

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":"Bearer ${user.token}"
    };

    print(headers);

    var response = await http.get(url,
        headers: headers
       );

    if(response.statusCode==401 || response.statusCode==500 || response.statusCode==403) {
      User.clear();
      alert(context,"Sessão expirada!");
      alertLogin(context);
    }

    print('Response status: ${response.statusCode}');
    Map mapResponse = jsonDecode(response.body);
    mapResponse.forEach((k,v)=> rotinas.add(Rotina.fromJson(v)));

    rotinas.forEach((f)=>print(f.tipoConteudo.categoria));

    return rotinas;
 }
}
