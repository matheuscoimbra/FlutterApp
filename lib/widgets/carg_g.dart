import 'package:fisc/page/acompanhamento/acompanhamento_form.dart';
import 'package:fisc/page/home/Card.dart';
import 'package:fisc/page/rotina/home_page.dart';
import 'package:fisc/utils/nav.dart';
import 'package:flutter/material.dart';

class CardG extends StatelessWidget {


  CardGi index;
  CardG(this.index);


  BoxDecoration _buildShadowAndRoundedCorners() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.4),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          spreadRadius: 2.0,
          blurRadius: 10.0,
          color: Colors.black26,
        ),
      ],
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
         index.avatar,
        ],
      ),
    );
  }



  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0),
      child: Text(
        index.titulo,
        style: TextStyle(color: Colors.white.withOpacity(0.85)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175.0,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      decoration: _buildShadowAndRoundedCorners(),
      child: InkWell(
        onTap: (){
          if(index.titulo=="Rotina"){
            push(context, HomePage());
          }else{
            push(context,AcompanhamentoForm());
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(flex: 3, child: _buildThumbnail()),
            Flexible(flex: 2, child: _buildInfo()),
          ],
        ),
      )
    );
  }
}
