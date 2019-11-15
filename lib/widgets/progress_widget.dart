import 'dart:io';

import 'package:fisc/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProgressWidget extends StatefulWidget {

  bool param2;
  bool msg;

  ProgressWidget(this.param2, this.msg);

  @override
  _ProgressWidgetState createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    showDialog(
     context: context,
     barrierDismissible: false,
     builder: (context) {  //  Navigator.of(context).pop(true);
       Future.delayed(Duration(seconds: 4), () {
         Future.delayed(Duration(seconds: 1), () {
           Navigator.of(context).pop(true);
         });
         setState(() {
           widget.param2=true;
         });
       });
       return Container(
         child: AlertDialog(
           actions: <Widget>[
             Stack(
               children: <Widget>[
                 new Container(
                   alignment: AlignmentDirectional.center,
                   decoration: new BoxDecoration(
                     color: Colors.white70,
                   ),
                   child: new Container(
                     decoration: new BoxDecoration(
                         color: Colors.blue[200],
                         borderRadius: new BorderRadius.circular(10.0)
                     ),
                     width: 300.0,
                     height: 200.0,
                     alignment: AlignmentDirectional.center,
                     child: new Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         new Center(
                           child: new SizedBox(
                             height: 50.0,
                             width: 50.0,
                             child: widget.param2?Icon(Icons.done, size: 50, color: Colors.white):new CircularProgressIndicator(
                               value: null,
                               strokeWidth: 7.0,
                             ),
                           ),
                         ),
                         new Container(
                           margin: const EdgeInsets.only(top: 25.0),
                           child: new Center(
                             child: new Text(
                               widget.msg?"aguarde...":"",
                               style: new TextStyle(
                                   color: Colors.white
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ],
             ),
           ],
         ),
       );
     },
   );
  }
}