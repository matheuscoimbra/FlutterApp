import 'dart:async';

import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/page/rotina/rotina_api.dart';
import 'package:flutter/cupertino.dart';

import 'acompanhamento.dart';
import 'acompanhamento_api.dart';

class AcompanhamentoBloc{
  final _streamControler =  StreamController<Acompanhamento>();

  get stream => _streamControler.stream;

  Future<Acompanhamento> loaldData(BuildContext context) async{
    try {
      Acompanhamento acompanhamento = await AcompanhamentoApi.getAcompanhamento(context);
      _streamControler.add(acompanhamento);
      return acompanhamento;
    }catch(e){
      _streamControler.addError(e);
    }
  }

  void dispose() {

    _streamControler.close();
  }

}