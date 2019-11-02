import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'acompanhamento.dart';
import 'acompanhamento_api.dart';

class AcompanhamentoBloc{
  final _streamControler =  StreamController<Acompanhamento>();

  get stream => _streamControler.stream;

  Future<Acompanhamento> loaldData(BuildContext context,int tipo, String dataIni, String dataFim) async{
    try {
      Acompanhamento acompanhamento = await AcompanhamentoApi.getAcompanhamento(context, tipo,  dataIni,  dataFim);
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