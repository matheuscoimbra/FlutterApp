

import 'package:fisc/page/login/login_api.dart';
import 'package:fisc/utils/simple_bloc.dart';

class LoginBloc extends SimpleBloc {

  login(String login, String senha) async {
    progress.setProgress(true);

    try {
      return await LoginApi.login(login,senha);
    } finally {
      progress.setProgress(false);
    }
  }
}
