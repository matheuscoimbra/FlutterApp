import 'package:fisc/drawer_list.dart';
import 'package:fisc/page/rotina/rotina.dart';
import 'package:flutter/material.dart';

class RotinaDetalhe extends StatefulWidget {

  Rotina rotina;
  String tipoRotina;


  RotinaDetalhe(this.rotina, this.tipoRotina);

  @override
  _RotinaDetalheState createState() => _RotinaDetalheState();
}

class _RotinaDetalheState extends State<RotinaDetalhe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhe Rotina"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Card(
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            color: ( widget.rotina.statusProcessamentoLabel=="PARADO" ||  widget.rotina.statusProcessamentoLabel=="ERRO")?Colors.redAccent[200]:( widget.rotina.statusProcessamentoLabel=="EM PARALISAÇÃO")?Colors.orange[400]:Colors.green[400],
            child: Center(
              child: Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    widget.rotina.tipoConteudo.categoria,
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
                    widget.rotina.tipoConteudo.categoria,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.grey[300],
                    ),
                  ),

                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Solid text as fill.
              Center(
                child: Text(
                  widget.tipoRotina,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Código", style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),
                      Text(widget.rotina.idProcessamento.toString(),
                        style: TextStyle(fontSize: 20),),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Quantidade processados", style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),
                      Text(widget.rotina.qtdConteudos.toString(),
                        style: TextStyle(fontSize: 20),),


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
                      Text("Incio Processamento", style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),
                      Text(widget.rotina.dtIniProc, style: TextStyle(fontSize: 20),),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Status", style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),
                      Text(widget.rotina.statusProcessamentoLabel,
                        style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Nsu Incial", style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),
                      Text(widget.rotina.nsuInicial!=null?widget.rotina.nsuInicial.toString():"",
                        style: TextStyle(fontSize: 20),),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Nsu Final", style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),
                      Text(widget.rotina.nsuFinal!=null?widget.rotina.nsuFinal.toString():"",
                        style: TextStyle(fontSize: 20),),


                    ],
                  ),
                ),
              ),


            ],
          ),
          ButtonTheme.bar( //
            padding: EdgeInsets.all(0), //// / / m//
            height: 0, // ake buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(

                  child: const Text('Voltar', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),),
                  onPressed: () {
                    Navigator.pop(context);/* ... */
                  },
                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}
