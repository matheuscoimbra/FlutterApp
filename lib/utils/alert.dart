import 'package:fisc/page/home/initial_page.dart';
import 'package:fisc/page/login/login_page.dart';
import 'package:fisc/page/rotina/home_page.dart';
import 'package:fisc/utils/nav.dart';
import 'package:fisc/widgets/rounded_button.dart';
import 'package:flutter/material.dart';


alertPg(BuildContext context, String msg, bool param2) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {  //
      Future.delayed(Duration(seconds: 6), () {
        Future.delayed(Duration(seconds: 1), () {

        });
        Navigator.of(context).pop(true);
      });
      return Container(
        child: AlertDialog(
          actions: <Widget>[
            Stack(
              children: <Widget>[
                new Container(
                  alignment: AlignmentDirectional.center,
                  decoration: new BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: new BorderRadius.circular(10.0)
                    ),
                    width: 300.0,
                    height: 200.0,
                    alignment: AlignmentDirectional.center,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Center(
                          child: new SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: param2?Icon(Icons.done, size: 50, color: Colors.white):new CircularProgressIndicator(
                              value: null,
                              strokeWidth: 7.0,
                            ),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(top: 25.0),
                          child: new Center(
                            child: new Text(
                              msg==null?"aguarde...":msg,
                              style: new TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}


alert(BuildContext context, String msg) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Sistema"),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}

alertHome(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Erro'),
      content: new Text('Você voltará para tela inicial'),
      actions: <Widget>[
        new GestureDetector(
            onTap: () => push(context, Home(),replace: true),
          child: roundedButton(
              " OK ", const Color(0xFF167F67), const Color(0xFFFFFFFF)),
        ),
      ],
    ),
  );
}

alertConexao(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Erro'),
      content: new Text('Sem Conexão'),
      actions: <Widget>[
        new GestureDetector(
          onTap: () => push(context, Home(),replace: true),
          child: roundedButton(
              " OK ", const Color(0xFF167F67), const Color(0xFFFFFFFF)),
        ),
      ],
    ),
  );
}

alertLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Sessão Expirada'),
      content: new Text('Você voltará para tela de login'),
      actions: <Widget>[
        new GestureDetector(
          onTap: () => push(context, LoginPage(),replace: true),
          child: roundedButton(
              " OK ", const Color(0xFF167F67), const Color(0xFFFFFFFF)),
        ),
      ],
    ),
  );
}
