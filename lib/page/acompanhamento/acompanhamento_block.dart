import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'acompanhamento.dart';
import 'acompanhamento_api.dart';
import 'acompanhamento_api_chart.dart';

class AcompanhamentoBloc{
  final _streamControler =  StreamController<Acompanhamento>();
  final _streamControler2 =  StreamController<AtrasoProcessaomento>();
  get stream => _streamControler.stream;
  get stream2 => _streamControler2.stream;

  Future<AtrasoProcessaomento> loaldDataChart(BuildContext context, Map<String,dynamic> value, int tipo) async{
    try {
      if(tipo==2) {
        AtrasoProcessaomento acompanhamento = await AtrasoProcessaomentoApiChart
            .getAcompanhamento(context, value);
        _streamControler2.add(acompanhamento);
        print(acompanhamento);
        return acompanhamento;
      }else{
        return null;
      }

    }catch(e){
      print(e);
      _streamControler2.addError(e);
    }
  }

  Future<Acompanhamento> loaldData(BuildContext context, Map<String,dynamic> value, int tipo) async{
    try {
      if(tipo==1) {
        Acompanhamento acompanhamento = await AcompanhamentoApi
            .getAcompanhamento(context, value);
        _streamControler.add(acompanhamento);
        return acompanhamento;
      }else{
        return null;
      }

    }catch(e){
      _streamControler.addError(e);
    }
  }
  void dispose2() {

    _streamControler2.close();
  }
  void dispose() {

    _streamControler.close();
  }

}