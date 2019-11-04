import 'package:enum_to_string/enum_to_string.dart';
import 'package:fisc/page/acompanhamento/acompanhamento_list.dart';
import 'package:fisc/page/acompanhamento/categoria.dart';
import 'package:fisc/utils/alert.dart';
import 'package:fisc/utils/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:math' as math;
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
             Container(
               height: 200,

            child:  Card(
              color: Colors.cyan,
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 16.0,),
                    Text("Monitoramento de Contéudo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),),
                    ListTile(
                      leading: Icon(Icons.calendar_today),
                      title: Text("Visualização por data",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      subtitle: Text("Situação da Carga / Processamento ",style: TextStyle( color: Colors.white)),
                    ),
                    ListTile(
                      leading: Icon(Icons.pie_chart),
                      title: Text("Visualização por processamento",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      subtitle: Text("Atraso /Avaliação do Tempo de Processamento",style: TextStyle( color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
              SizedBox(
                height: 30.0,
              ),
              FormBuilder(
                key: _fbKey,
                initialValue: {
                  'date': DateTime.now(),
                  'accept_terms': false,
                },
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    FormBuilderDateTimePicker(
                      attribute: "ini",
                      inputType: InputType.date,
                      format: DateFormat("dd/MM/yyyy"),
                      decoration:
                      InputDecoration(labelText: "Data Inicial"),
                    ),
                    SizedBox(
                      height: 30.0,
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
                      validators: [FormBuilderValidators.required(errorText: "Escolha uma categoria")],
                      items: ['NFE',  'CTE',  'MDFE',  'NFCE',  'EFD',  'CTEOS',  'DIEF',  'GIA_ST',  'CONV_115',  'BPE',  'PGDASD',  'TEF',  'DEFIS',  'NFE_EVENTO',  'CTE_EVENTO',  'MDFE_EVENTO',  'NFCE_EVENTO',  'EFD_OIE',  'SCANC',  'DI',  'CCC',  'DESTDA']
                          .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text("$gender")
                      )).toList(),
                    ),


                  ],
                ),
              ),
              SizedBox(
                height: 120.0,
              ),
              Row(
                children: <Widget>[


                  MaterialButton(
                    minWidth: 100.0,
                    height: 35,
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                    child: Text("Pesquisar", style: TextStyle( color: Colors.white),),
                    elevation: 18.0,
                    clipBehavior:  Clip.antiAlias,
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        print(_fbKey.currentState.value);
                        var ini = _fbKey.currentState.value['ini'];
                        ini = new DateFormat('yyyy-MM-dd','pt').format(ini);
                        var fim = _fbKey.currentState.value['fim'];
                        fim = new DateFormat('yyyy-MM-dd','pt').format(fim);

                        var start = DateTime.parse(ini);
                        var end = DateTime.parse(fim);
                        Duration difference = end.difference(start);
                        print(difference.inDays);
                        if(difference.inDays>30){
                          alert(context,"Data não pode ter diferença maior do que 30 dias");
                        }else{
                          push(context,AcompanhamentoList(_fbKey.currentState.value));

                        }

                      }
                    },
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  MaterialButton(

                    child: Text("Limpar",style: TextStyle( color: Colors.white)),
                    elevation: 18.0,
                    minWidth: 100.0,
                    height: 35,
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                    clipBehavior:  Clip.antiAlias,
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
