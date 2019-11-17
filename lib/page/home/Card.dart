import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class CardGi {
  CardGi({
    @required this.titulo,
    @required this.subtitulo,
    @required this.avatar,
    @required this.backdropPhoto,
    @required this.location,
    @required this.info,

  });

  final String titulo;
  final String subtitulo;
  final Widget avatar;
  final String backdropPhoto;
  final String location;
  final String info;

}