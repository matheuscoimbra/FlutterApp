import 'package:enum_to_string/enum_to_string.dart';
import 'package:fisc/page/acompanhamento/acompanhamento_list.dart';
import 'package:fisc/page/acompanhamento/categoria.dart';
import 'package:fisc/utils/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../drawer_list.dart';

class AcompanhamentoForm extends StatefulWidget {
  @override
  _AcompanhamentoFormState createState() => _AcompanhamentoFormState();
}

class _AcompanhamentoFormState extends State<AcompanhamentoForm> {

  String _selected;
  int _selectApi;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ValueChanged _onChanged = (val) => print(val);
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

          child: ListView(

            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                initialValue: {
                  'date': DateTime.now(),
                  'accept_terms': false,
                },
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    FormBuilderDateTimePicker(
                      attribute: "ini",
                      inputType: InputType.date,
                      format: DateFormat("dd/MM/yyyy"),
                      decoration:
                      InputDecoration(labelText: "Data Inicial"),
                    ),
                    FormBuilderDateTimePicker(
                      attribute: "fim",
                      inputType: InputType.date,
                      format: DateFormat("dd/MM/yyyy"),
                      decoration:
                      InputDecoration(labelText: "Data Final"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FormBuilderDropdown(
                      attribute: "gender",

                      decoration: InputDecoration(labelText: "Categoria"),
                      // initialValue: 'Male',
                      hint: Text('Categoria'),
                      disabledHint: Text('Campo não pode ser vazio'),
                      underline: Text('Campo não pode ser vazio'),

                      icon: Icon(
                        Icons.arrow_downward
                      ),
                      validators: [FormBuilderValidators.required()],
                      items: ['NFE',  'CTE',  'MDFE',  'NFCE',  'EFD',  'CTEOS',  'DIEF',  'GIA_ST',  'CONV_115',  'BPE',  'PGDASD',  'TEF',  'DEFIS',  'NFE_EVENTO',  'CTE_EVENTO',  'MDFE_EVENTO',  'NFCE_EVENTO',  'EFD_OIE',  'SCANC',  'DI',  'CCC',  'DESTDA']
                          .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text("$gender")
                      )).toList(),
                    ),


                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text("Submit"),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        print(_fbKey.currentState.value);
                        push(context,AcompanhamentoList(_fbKey.currentState.value));
                      }
                    },
                  ),
                  MaterialButton(
                    child: Text("Reset"),
                    onPressed: () {
                      _fbKey.currentState.reset();
                    },
                  ),
                ],
              )
            ],

          ),


    );
  }
}
