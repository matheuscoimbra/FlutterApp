import 'dart:convert';
import 'dart:math';

import 'package:fisc/page/api_response.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/page/rotina/rotina.dart';
import 'package:http/http.dart' as http;

class RotinaApiAtivar {
 static Future<String> ativar(int idProcessamento) async {

    User user =await User.get();
    var url =
        'services/rotina/parar/$idProcessamento';

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization":"Bearer ${user.token}"
    };

    print(url);

    var response = await http.get(url,
        headers: headers
       );
    print('Response status: ${response.statusCode}');
   String result =  response.body;
    print(result);

    return result;
 }
}
