import 'package:fisc/page/login/login_page.dart';
import 'package:fisc/utils/nav.dart';
import 'package:fisc/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

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
