import 'dart:convert';

import 'package:fisc/page/api_response.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/utils/alert.dart';
import 'package:fisc/utils/prefs.dart';
import 'package:fisc/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:device_id/device_id.dart';

class LoginApi {
  static Future<ApiResponse<UsuarioResponse>> login(String login, String Senha) async {

    try{
      var url =
          'http://192.168.:8082/sped-web/services/usuario/autenticacao';
      String device_id = await DeviceId.getID;
      Map params = {
        'login': login,
        'senha': Senha,
        'telefoneId': 'cdaa1947-ea95-4871-80e6-f38265f2d758'
      };

      var body = json.encode(params);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}
          , body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');


      Map mapResponse = jsonDecode(response.body);

      if(response.statusCode==200){
        final user = UsuarioResponse.fromJson(mapResponse);
        user.user.save();
        User user2 = await User.get();

        return ApiResponse.ok(user);
      }
      return ApiResponse.error(mapResponse["error"]);
    }catch(error, exception){
      print("erro no login");
      return ApiResponse.error("Não foi possível fazer o login");
    }
  }

}
