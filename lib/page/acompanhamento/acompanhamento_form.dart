import 'package:enum_to_string/enum_to_string.dart';
import 'package:fisc/page/acompanhamento/categoria.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../drawer_list.dart';

class AcompanhamentoForm extends StatefulWidget {
  @override
  _AcompanhamentoFormState createState() => _AcompanhamentoFormState();
}

class _AcompanhamentoFormState extends State<AcompanhamentoForm> {

  String _selected;
  int _selectApi;

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

  String enumValueToString(Object o) => o.toString().split('.').last;

  T enumValueFromString<T>(String key, List<T> values) =>
      values.firstWhere((v) => key == enumValueToString(v), orElse: () => null);
//https://stackoverflow.com/questions/29567236/dart-how-to-get-the-value-of-an-enum
  _body(){
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: DropdownButton<String>(
          value: _selected,
          items: Categoria.entries
              .map<DropdownMenuItem<String>>(
                  (MapEntry<String, String> e) => DropdownMenuItem<String>(
                value: e.key,
                child: Text(e.value),
              ))
              .toList(),
          onChanged: (newValue) {
            setState(() {
              _selected = newValue;

            });
          },
          isExpanded: true,
          icon: Icon(Icons.arrow_downward),
          elevation: 16,
          style: TextStyle(
              color: Colors.deepPurple
          ),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          )
        ),
      )
      ,
    );
  }
}
