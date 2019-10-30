import 'package:fisc/drawer_list.dart';
import 'package:fisc/main.dart';
import 'package:fisc/page/acompanhamento/acompanhamento_block.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    _block.loaldData(context);
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
    await _block.loaldData(context);
    return;
  }

  Container _listView(Hst acompanhamento) {
    return Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: acompanhamento.historico != null
                ? acompanhamento.historico.length
                : 0,
            itemBuilder: (context, int index) {

              var key = acompanhamento.historico.keys.elementAt(index);

              return Container(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.blueGrey[100],
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text(
                            "${ new DateFormat('dd/MM/yyyy (EEEE)','pt').format(DateTime.parse(key))}",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                        ),
                      ),
                      Divider(
                      height: 10.0,
                        color: Colors.black,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  color: acompanhamento.historico[key][0].estilo=="com_erro"?Colors.redAccent:Colors.blue,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "${acompanhamento.historico[key][0].nome}",
                                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${acompanhamento.historico[key][0].descricao}",
                                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  color: acompanhamento.historico[key][1].estilo=="com_erro"?Colors.redAccent:Colors.blue,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "${acompanhamento.historico[key][1].nome}",
                                        style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${acompanhamento.historico[key][1].descricao}",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
