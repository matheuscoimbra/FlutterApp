import 'package:fisc/drawer_list.dart';
import 'package:fisc/page/acompanhamento/acompanhamento_block.dart';
import 'package:flutter/material.dart';

import 'acompanhamento.dart';

class AcompanhamentoList extends StatefulWidget {
  @override
  _AcompanhamentoListState createState() => _AcompanhamentoListState();
}

class _AcompanhamentoListState extends State<AcompanhamentoList> {

  Acompanhamento acompanhamento;
  final _block = AcompanhamentoBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _block.loaldData( context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acompanhamento"),
        centerTitle: true,
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {

    return Container(
      color: Colors.orange,
      child: StreamBuilder(
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

         Acompanhamento acompanhamento = snapshot.data;
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: _listView(acompanhamento.hst),
          );
        },
      )
    );


  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _block.dispose();

  }

  Future<void> _onRefresh() async{
    await _block.loaldData(context);
    return;
  }

 Container _listView(Hst acompanhamento) {
   return Container(
       padding: EdgeInsets.all(16),
   child: ListView.builder(
   itemCount: acompanhamento.historico!=null? acompanhamento.historico.length : 0,
   itemBuilder: (context,index){

     acompanhamento.historico.forEach((k,v){

          v.forEach((f){
            print('value ()()()() ${f}');
            return Card(
                color:  Colors.grey[100],
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(f.data
                        ,
                        style: TextStyle(
                          fontSize: 40,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Colors.blue[700],
                        ),
                      ),
                      Card(
                        color: Colors.black12,
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              // Stroked text as border.
                              Text(
                                f.nome,
                                style: TextStyle(
                                  fontSize: 20,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Colors.blue[700],
                                ),
                              ),
                              // Solid text as fill.
                              Text(
                                f.descricao,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )

                    ]
                ));
          });

        });


   }
    ));


  }

}

