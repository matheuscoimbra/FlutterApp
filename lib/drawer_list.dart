import 'package:fisc/page/acompanhamento/acompanhamento_list.dart';
import 'package:fisc/page/home/initial_page.dart';
import 'package:fisc/page/login/login_page.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/page/rotina/home_page.dart';
import 'package:fisc/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future<User> user = User.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
           FutureBuilder<User>(
             future:  user,
             builder:(context,snapshot){
               User user = snapshot.data;
               return user!=null?_header(user):Container();
             } ,
           ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              subtitle: Text("Página de incio"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                push(context, Home());
              },
            ),
            ListTile(
              leading: Icon(Icons.apps),
              title: Text("Rotinas"),
              subtitle: Text("Gerenciamento de Rotinas e Serviços..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                push(context, HomePage());
              },
            ),
            ListTile(
              leading: Icon(Icons.all_inclusive),
              title: Text("Acompanhamento"),
              subtitle: Text("Acompanhamento de conteúdos..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("carga");
                push(context,AcompanhamentoList());

              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _header(User user) {
    return UserAccountsDrawerHeader(
            accountName: Text(user.login),
            accountEmail: Text(user.nome),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://media.licdn.com/dms/image/C4E0BAQEz2vTBRFh6Qw/company-logo_200_200/0?e=2159024400&v=beta&t=eet2EKr0GEwEujtH4YeQDNIvFwgfnJOmSfh73m4zXlY"),
            ),
          );
  }

  _onClickLogout(BuildContext context) {
    User.clear();
   Navigator.pop(context);
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
