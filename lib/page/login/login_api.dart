import 'dart:convert';

import 'package:fisc/page/api_response.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/utils/prefs.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<UsuarioResponse>> login(String login, String Senha) async {
   try{
     var url =
         '/services/usuario/autenticacao';

     Map params = {
       'login': login,
       'senha': Senha,
     };

     var body = json.encode(params);

     var response = await http.post(url,
         headers: {"Content-Type": "application/json"}
         , body: body);
     print('Response status: ${response.statusCode}');
     print('Response body: ${response.body}');

     /*  Map mapResponse = jsonDecode(response.body);
    mapResponse.forEach((k,v)=> print(Rotina.fromJson(v).idProcessamento));*/

     Map mapResponse = jsonDecode(response.body);

     if(response.statusCode==200){
       final user = UsuarioResponse.fromJson(mapResponse);
       print(user);
        user.user.save();
        User user2 = await User.get();

        print("user2: $user2");

       return ApiResponse.ok(user);
     }
     return ApiResponse.error(mapResponse["error"]);
   }catch(error, exception){
      print("erro no login");
      return ApiResponse.error("Não foi possível fazer o login");
   }
  }
}
