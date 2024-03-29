
import 'dart:async';
import 'dart:convert';

import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/page/rotina/rotina_api.dart';
import 'package:fisc/page/rotina/rotina_api_ativar.dart';
import 'package:fisc/page/rotina/rotina_block.dart';
import 'package:fisc/page/rotina/rotina_detalhe.dart';
import 'package:fisc/utils/alert.dart';
import 'package:fisc/utils/alert_progress.dart';
import 'package:fisc/utils/event_bus.dart';
import 'package:fisc/utils/nav.dart';
import 'package:fisc/widgets/icon_widget.dart';
import 'package:fisc/widgets/progress_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../main.dart';

class RotinasListView extends StatefulWidget {

  String _tipoRotina;
  RotinasListView(this._tipoRotina);

  @override
  _RotinasListViewState createState() => _RotinasListViewState();
}

class _RotinasListViewState extends State<RotinasListView> with AutomaticKeepAliveClientMixin<RotinasListView> {
  List<Rotina> rotinas;
  ProgressDialog pr;
  StreamSubscription<Event> subscription;
  final _block = RotinaBloc();
  bool showProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _block.loaldData(widget._tipoRotina, context);

    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);

    pr.style(message: 'Aguarde....');
    // Escutando uma stream
    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event e){
      print("Event $e");
      RotinaEvent carroEvent = e;
      if(carroEvent.tipo == widget._tipoRotina) {
        print("evento ${widget._tipoRotina}");
        _block.loaldData(widget._tipoRotina, context);
      }
    });

  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);

    pr.style(message: 'Aguarde....');
    return _body();
  }

  _body()  {


    return StreamBuilder(
      stream: _block.stream,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text(
              "Não foi possivel realizar consulta", style: TextStyle(fontSize: 22, color: Colors.red),
            ));
        }
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Rotina> rtinas = snapshot.data;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: _listView(rtinas),
        );
      },
    );
  }

  Container _listView(List<Rotina> rotinas) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: rotinas!=null? rotinas.length:0,
          itemBuilder: (context,index){
            Rotina r  = rotinas[index];

            return (r.tipoConteudo.controle=="COMPLETO" && r.idProcessamento==null)?Card(
              color:  Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    color: Colors.black12,
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            r.tipoConteudo.categoria,
                            style: TextStyle(
                              fontSize: 40,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.blue[700],
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            r.tipoConteudo.categoria,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) ,
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Código",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              Text(r.idProcessamento!=null?r.idProcessamento.toString():"", style: TextStyle(fontSize: 12),),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Quantidade processados",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              Text(r.qtdConteudos!=null?r.qtdConteudos.toString():"", style: TextStyle(fontSize: 12),),


                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Incio Processamento",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              Text(r.dtIniProc!=null?r.dtIniProc:"", style: TextStyle(fontSize: 12),),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Status",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              Text(r.statusProcessamentoLabel!=null?r.statusProcessamentoLabel:"", style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ButtonTheme.bar( //
                    padding: EdgeInsets.all(0),//// / / m//
                    height: 0,// ake buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        showProgress? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ):FlatButton(
                          child:   Text('Ativar',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          onPressed: () {
                            print("Botão de ativar pressionado!");
                            pr.show();
                            Future.delayed(Duration(seconds: 3), () {
                              pr.update(message: 'Quase lá...');
                            });

                            RotinaApiAtivar.ativar(
                                "ativar", r.tipoConteudo.idTipoConteudo,
                                r.tipoProcessamento, context,
                                widget._tipoRotina).then(
                                    (res)=> {

                                    pr.update(message: jsonDecode(res)["message"], messageTextStyle: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold)) ,
                                    Future.delayed(Duration(seconds: 1), () {
                                      if(pr.isShowing()){
                                        pr.hide();
                                      }
                                    }),

                                  //alert(context,jsonDecode(res)["message"]),
                                  super.reassemble()
                                }
                            );
                            pr.update(message: 'Aguade...');
                          })

                      ],
                    ),
                  )
                ],
              ),
            ):((r.idProcessamento!=null && r.tipoConteudo.controle!="COMPLETO"  && widget._tipoRotina=="download")||(r.tipoConteudo.controle=="monitoramento"  && widget._tipoRotina=="sequencias"))?
            Card(
              color: Colors.grey[100],
              child: Column(
                children: <Widget>[
                  Center(
                    child: Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          r.tipoConteudo.categoria,
                          style: TextStyle(
                            fontSize: 40,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = Colors.blue[700],
                          ),
                        ),
                        // Solid text as fill.
                        Text(
                          r.tipoConteudo.categoria,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ) ,
                  IconWidget(FontAwesomeIcons.ban, "Não se Aplica")
                ],
              ),
            ):((r.tipoConteudo.controle=="COMPLETO" || r.tipoConteudo.controle=="MONITORAMENTO") && r.idProcessamento!=null)?Card(
              color:  Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    color: (r.statusProcessamentoLabel=="PARADO" || r.statusProcessamentoLabel=="ERRO")?Colors.redAccent[200]:(r.statusProcessamentoLabel=="EM PARALISAÇÃO")?Colors.orange[400]:Colors.green[400],
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            r.tipoConteudo.categoria,
                            style: TextStyle(
                              fontSize: 40,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.blue[700],
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            r.tipoConteudo.categoria,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) ,
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Código",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              Text(r.idProcessamento.toString(), style: TextStyle(fontSize: 12),),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Quantidade processados",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              Text(r.qtdConteudos.toString(), style: TextStyle(fontSize: 12),),


                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Incio Processamento",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              Text(r.dtIniProc, style: TextStyle(fontSize: 12),),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Status",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              Text(r.statusProcessamentoLabel, style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ButtonTheme.bar( //
                    padding: EdgeInsets.all(0),//// / / m//
                    height: 0,// ake buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(

                          child: const Text('Detalhar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          onPressed: () {
                            push(context,RotinaDetalhe(r,widget._tipoRotina));/* ... */ },
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        showProgress? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ):
                       (r.statusProcessamentoLabel.contains("PARADO") || r.statusProcessamentoLabel.contains("EM PARALISAÇÃO") || r.statusProcessamentoLabel.contains("CONCLUIDO (aguard próx execução...)")) ?
                        FlatButton(
                          child:  Text('Ativar',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          onPressed: () {
                            pr.show();
                            Future.delayed(Duration(seconds: 3), () {
                              pr.update(message: 'Quase lá...');
                            });
                            RotinaApiAtivar.ativar("ativar",r.tipoConteudo.idTipoConteudo,r.tipoProcessamento,context,widget._tipoRotina).then(
                                    (res)=> {

                                      pr.update(message: jsonDecode(res)["message"], messageTextStyle: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold)) ,
                                  Future.delayed(Duration(seconds: 1), () {
                                    if(pr.isShowing()){
                                      pr.hide();
                                    }
                                  }),

                                  //alert(context,jsonDecode(res)["message"]),
                                  super.reassemble()
                                }
                          );
                            pr.update(message: 'Aguade...');
                            /*super.didUpdateWidget(RotinasListView(widget._tipoRotina));*/
                          },
                        ):FlatButton(
                          child: const Text('Parar',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          onPressed: () {
                            pr.show();
                            Future.delayed(Duration(seconds: 3), () {
                              pr.update(message: 'Quase lá...');
                            });
                            ProgressWidget(false,false);
                            RotinaApiAtivar.ativar("parar",r.tipoConteudo.idTipoConteudo,r.tipoProcessamento,context,widget._tipoRotina).then(
                                    (res)=> {

                                      pr.update(message: jsonDecode(res)["message"], messageTextStyle: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold)) ,
                                  Future.delayed(Duration(seconds: 1), () {
                                    if(pr.isShowing()){
                                      pr.hide();
                                    }
                                  }),

                                  //alert(context,jsonDecode(res)["message"]),
                                  super.reassemble()
                                }
                          );
                            pr.update(message: 'Aguade...');
                            /*super.didUpdateWidget(RotinasListView(widget._tipoRotina));*/
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ):Card(
              color: Colors.grey[100],
              child: Column(
                children: <Widget>[
                  Center(
                    child: Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          r.tipoConteudo.categoria,
                          style: TextStyle(
                            fontSize: 40,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = Colors.blue[700],
                          ),
                        ),
                        // Solid text as fill.
                        Text(
                          r.tipoConteudo.categoria,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ) ,
                  IconWidget(FontAwesomeIcons.ban, "Não se Aplica")
                ],
              ),
            );
          }),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _block.dispose();
    subscription.cancel();
  }

  Future<void> _onRefresh() async{
    await _block.loaldData(widget._tipoRotina,context);
    return;
  }
}
