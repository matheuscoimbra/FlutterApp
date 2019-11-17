import 'package:cached_network_image/cached_network_image.dart';
import 'package:fisc/page/home/Card.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'carg_g.dart';

class Inicio extends StatelessWidget {

  List<CardGi> card = <CardGi>[CardGi(titulo: "Rotina", subtitulo: "Acompanhamentod de conteudo", avatar: CachedNetworkImage(
    imageUrl: "https://img.icons8.com/plasticine/2x/process.png", fit: BoxFit.contain,)
      ,info: "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e "
          "vem sendo utilizado desde o século XVI, ",backdropPhoto: null,location: null),
    CardGi(titulo: "Acompanhamento", subtitulo: "Processamento de conteudo", avatar: CachedNetworkImage(
      imageUrl: "https://cdn2.iconfinder.com/data/icons/web-and-mobile-ui-volume-24/48/1151-512.png", fit: BoxFit.contain,)
        ,info: "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e "
            "vem sendo utilizado desde o século XVI, ",backdropPhoto: null,location: null)];

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(),
          _buildInfo(),
          _buildVideoScroller(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white30),
      ),
      margin: const EdgeInsets.only(top: 32.0, left: 16.0),
      padding: const EdgeInsets.all(3.0),
      child: ClipOval(
        child:  CachedNetworkImage(
          imageUrl: "https://media.licdn.com/dms/image/C4E0BAQEz2vTBRFh6Qw/company-logo_200_200/0?e=2159024400&v=beta&t=eet2EKr0GEwEujtH4YeQDNIvFwgfnJOmSfh73m4zXlY", fit: BoxFit.cover,),

      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "SECRETÁRIA DA FAZENDO DO MARANHÃO",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          Text(
            "São Luis, MA",
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.85),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            width: 225.0,
            height: 1.0,
          ),
          Text(
            "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. ",
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoScroller() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox.fromSize(
        size: Size.fromHeight(245.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return CardG(card[index]);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: "https://www.policiacivil.ma.gov.br/wp-content/uploads/2017/04/logo-governoma-2015.png", fit: BoxFit.cover,),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }
}
