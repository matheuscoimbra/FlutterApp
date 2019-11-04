import 'package:fisc/drawer_list.dart';
import 'package:fisc/main.dart';
import 'package:fisc/page/acompanhamento/acompanhamento_block.dart';
import 'package:fisc/page/acompanhamento/acompanhamento_chart.dart';
import 'package:fisc/utils/nav.dart';
import 'package:fisc/utils/utils.dart';
import 'package:fisc/widgets/utils_widget.dart';
import 'package:fisc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'acompanhamento.dart';

class AcompanhamentoList extends StatefulWidget {
  Map<String,dynamic> value;

  AcompanhamentoList(this.value);

  @override
  _AcompanhamentoListState createState() => _AcompanhamentoListState();
}

class _AcompanhamentoListState extends State<AcompanhamentoList> {
  Acompanhamento acompanhamento;
  final _block = AcompanhamentoBloc();
  Screen size;
  bool _gridView = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _block.loaldData(context,widget.value,1);
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          push(context,AcompanhamentoChart(widget.value));
        },
        child: Icon(Icons.pie_chart_outlined),
      ),
      appBar: AppBar(
        title: Text("Acompanhamento"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: (){
              setState(() {
                _gridView=false;
              });
            } ,
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: (){
              setState(() {
                _gridView=true;
              });
            } ,
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
        child: StreamBuilder(
      stream: _block.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
            "Não foi possivel realizar consulta",
            style: TextStyle(fontSize: 22, color: Colors.red),
          ));
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        Acompanhamento acompanhamento = snapshot.data;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: _listView(acompanhamento.hst),
        );
      },
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _block.dispose();
  }

  Future<void> _onRefresh() async {
    await _block.loaldData(context, widget.value,1);
    return;
  }

  Container _listView(Hst acompanhamento) {
    return _gridView?Container(
        padding: EdgeInsets.all(5.0),
        child: GridView.builder(

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: acompanhamento.historico != null
                ? acompanhamento.historico.length
                : 0,
            itemBuilder: (context, int index) {

              var key = acompanhamento.historico.keys.elementAt(index);

              return Container(
                  child: Column(
                    children: <Widget>[upperPart(key, key2:acompanhamento.historico)],
                  ),
              );
            })) :Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: acompanhamento.historico != null
                ? acompanhamento.historico.length
                : 0,
            itemBuilder: (context, int index) {

              var key = acompanhamento.historico.keys.elementAt(index);

              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[upperPart(key, key2:acompanhamento.historico)],
                  ),
                ),
              );
            }));
  }

  Widget upperPart( key, {key2}) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: _gridView? size.getWidthPx(147): size.getWidthPx(240),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorCurve, colorCurveSecondary],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: size.getWidthPx(16)),
              child: Column(
                children: <Widget>[
                  titleWidget(key),
                  SizedBox(height: size.getWidthPx(10)),
                  upperBoxCard(key, key2:key2),
                ],
              ),
            ),
    ]
        )

      ]
    );
  }
  Text titleWidget(var key) {
    return Text( "${ new DateFormat('dd/MM/yyyy (EEEE)','pt').format(DateTime.parse(key))}",
        style: TextStyle(
            fontFamily: 'Exo2',
            fontSize: _gridView?14.0:24.0,
            fontWeight: FontWeight.w900,
            color: Colors.white));
  }

  Card upperBoxCard(var key,{key2}) {
    return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(
            horizontal: size.getWidthPx(10), vertical: size.getWidthPx(16)),
        borderOnForeground: true,
        child: Container(
          height: _gridView?size.getWidthPx(97):size.getWidthPx(166),
          child: Column(
            children: <Widget>[
              leftAlignText(
                  text: "Resultados :",
                  leftPadding: size.getWidthPx(16),
                  textColor: textPrimaryColor,
                  fontSize:  _gridView?8.0:16.0),
              Container(
                color: key2[key][0].estilo=="com_erro"?Colors.redAccent:Colors.greenAccent,
                child: CenterAlignText(
                    text: "${key2[key][0].nome}",
                    textColor: textPrimaryColor,
                    fontSize: _gridView?8.0:16.0),
              ),


              SizedBox(
                height: 10.0,
              ),

              CenterAlignText(
                  text: "${key2[key][0].descricao}",
                  textColor: textPrimaryColor,
                  fontSize: _gridView?8.0:16.0),

              Divider(
                color: Colors.black,
                height: 20.0,
              ),
              Container(
                color: key2[key][1].estilo=="com_erro"?Colors.redAccent:Colors.greenAccent,
                child: CenterAlignText(
                    text: "${key2[key][1].nome}",
                    textColor: textPrimaryColor,
                    fontSize: _gridView?8.0:16.0),
              ),

              SizedBox(
                height: 10.0,
              ),
              CenterAlignText(
                  text: "${key2[key][1].descricao}",
                  textColor: textPrimaryColor,
                  fontSize: _gridView?8.0:16.0),




            ],
          ),
        ));
  }
}
