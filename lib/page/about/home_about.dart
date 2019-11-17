import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../drawer_list.dart';
class HomeBout extends StatelessWidget {
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
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Text("Em construção...", style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),),
            SizedBox(height: 45,),
            Container(
              child: Icon(Icons.build, size: 250,color: Colors.black,),
            )
          ],
        ),
      )
    );
  }
}
