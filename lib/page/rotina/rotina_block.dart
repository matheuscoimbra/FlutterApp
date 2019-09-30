import 'dart:async';

import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/page/rotina/rotina_api.dart';

class RotinaBloc{
  final _streamControler =  StreamController<List<Rotina>>();

  get stream => _streamControler.stream;

  Future<List<Rotina>> loaldData(String tipo) async{
    try {
      List<Rotina> rotinas = await RotinaApi.getRotinas(tipo);
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