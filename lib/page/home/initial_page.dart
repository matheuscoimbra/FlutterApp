

import 'package:fisc/page/rotina/home_page.dart';
import 'package:fisc/utils/nav.dart';
import 'package:flutter/material.dart';

import '../../drawer_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: _body(),
      drawer: DrawerList(),
    );
}

  _body() {
  return Container(
    padding: EdgeInsets.all(16),
    child: ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                      Text("Rotina", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black) ,),
                      SizedBox(height: 10,),
                      Text("Para interagir com as rotinas clique no botão abaixo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                    ButtonTheme.bar( //
                      padding: EdgeInsets.all(0),//// / / m//
                      height: 0,// ake buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('Ir',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            onPressed: () {
                              push(context, HomePage());
                            },
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.indigoAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text("Execução", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black) ,),
                    SizedBox(height: 10,),
                    Text("Para interagir com as rotinas clique no botão abaixo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                    ButtonTheme.bar( //
                      padding: EdgeInsets.all(0),//// / / m//
                      height: 0,// ake buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('Ir',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            onPressed: () {
                              push(context, HomePage());
                            },
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ),

  );
  }
}
