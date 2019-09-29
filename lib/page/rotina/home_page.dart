import 'package:fisc/drawer_list.dart';
import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/page/rotina/rotina_api.dart';
import 'package:fisc/page/rotina/rotina_listview.dart';
import 'package:fisc/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin<HomePage>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rotinas"),
          bottom: TabBar(
              labelStyle: TextStyle(fontSize:  9.0, ),
              tabs: [
                Wrap(
                  verticalDirection: VerticalDirection.down,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Tab(icon: Icon(Icons.archive)),
                    Container(

                        child: Text("DOWNLOAD DE ARQUIVOS"))
                  ],),
                Wrap(
                  verticalDirection: VerticalDirection.down,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Tab(icon: Icon(Icons.clear_all)),
                    Container(
                        child: Text("VERIFICAÇÃO DE LACUNAS"))
                  ],),
                Wrap(
                  verticalDirection: VerticalDirection.down,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Tab(icon: Icon(Icons.dashboard)),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("EXPLOSAO DOS DADOS"))
                  ],),
            Wrap(
              verticalDirection: VerticalDirection.down,
              alignment: WrapAlignment.center,
              children: <Widget>[
              Tab(icon: Icon(Icons.format_color_text)),
                Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("ANÁLISE DO CONTEÚDO"))
            ],),

          ]),
          centerTitle: true,
        ),
        drawer: DrawerList(),
        body: TabBarView(
          children: <Widget>[
            RotinasListView("download"),
            RotinasListView("sequencias"),
            RotinasListView("arquivos"),
            RotinasListView("analise")
          ],
        ),
      ),
    );
  }
}
