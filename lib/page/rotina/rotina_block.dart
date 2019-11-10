import 'dart:async';

import 'package:fisc/page/rotina/rotina.dart';
import 'package:fisc/page/rotina/rotina_api.dart';
import 'package:fisc/utils/simple_bloc.dart';
import 'package:flutter/cupertino.dart';

class RotinaBloc  extends SimpleBloc<List<Rotina>> {


  Future<List<Rotina>> loaldData(String tipo,BuildContext context) async{
    try {
      List<Rotina> rotinas = await RotinaApi.getRotinas(context,tipo);
      add(rotinas);
      return rotinas;
    }catch(e){
      addError(e);
    }
  }



}