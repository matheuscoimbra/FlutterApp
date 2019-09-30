import 'dart:async';

import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/page/rotina/rotina_api.dart';
import 'package:flutter/cupertino.dart';

class RotinaBloc{
  final _streamControler =  StreamController<List<Rotina>>();

  get stream => _streamControler.stream;

  Future<List<Rotina>> loaldData(String tipo,BuildContext context) async{
    try {
      List<Rotina> rotinas = await RotinaApi.getRotinas(context,tipo);
      _streamControler.add(rotinas);
      return rotinas;
    }catch(e){
      _streamControler.addError(e);
    }
  }

  void dispose() {

    _streamControler.close();
  }

}