import 'dart:math';

import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:fisc/drawer_list.dart';
import 'package:fisc/main.dart';
import 'package:fisc/page/acompanhamento/acompanhamento_block.dart';
import 'package:fisc/utils/utils.dart';
import 'package:fisc/widgets/utils_widget.dart';
import 'package:fisc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;
import 'acompanhamento.dart';

class AcompanhamentoChart extends StatefulWidget {
  Map<String,dynamic> value;

  AcompanhamentoChart(this.value);

  @override
  _AcompanhamentoChartState createState() => _AcompanhamentoChartState();
}

class _AcompanhamentoChartState extends State<AcompanhamentoChart> {
  final _block = AcompanhamentoBloc();
  Screen size;
  bool _gridView = true;
  double troke = 0;
  List<charts.Series<ListaSeries, String>> _seriesPieData;
  _generateData(mydata) {
    _seriesPieData = List<charts.Series<ListaSeries, String>>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (ListaSeries task, _) =>  task.name,
        measureFn: (ListaSeries task, _) => task.y.toInt(),
        colorFn: (ListaSeries task, _) =>
            charts.ColorUtil.fromDartColor(Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0)
            ),
        id: 'tasks',
        data: mydata,
        labelAccessorFn: (ListaSeries row, _) => "${row.y}",
      ),
    );
    _seriesPieData.forEach((f){
     f.data.forEach((h){
       print(h.y.toInt());
     });
    });
  }
  List<ListaSeries> listaSeries;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _block.loaldDataChart(context,widget.value,2);
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(

      appBar: AppBar(
        title: Text("Atraso"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
        child: StreamBuilder(
      stream: _block.stream2,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
            "Não foi possivel realizar consulta",
            style: TextStyle(fontSize: 22, color: Colors.red),
          ));
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        AtrasoProcessaomento atrasoProcessaomento = snapshot.data;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: _buildChart(context,atrasoProcessaomento),
        );
      },
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _block.dispose2();
  }

  Future<void> _onRefresh() async {
    await _block.loaldData(context, widget.value,2);
    return;
  }

  Widget _buildChart(BuildContext context, AtrasoProcessaomento taskdata) {
    listaSeries = taskdata.listaSeries;
    _generateData(listaSeries);
    var _troke = 0.0;
    return  Padding(
      padding: EdgeInsets.all(16.0),
       child: Container(
         padding: EdgeInsets.all(16.0),

          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                Text(
                  'Atrasos',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: () => _change(),
                    child: charts.PieChart(_seriesPieData,
                        animate: true,
                        animationDuration: Duration(seconds: 2),

                        behaviors: [
                          new charts.DatumLegend(
                            outsideJustification:
                            charts.OutsideJustification.middleDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 5,
                            cellPadding:
                            new EdgeInsets.only(right: 4.0, bottom: 4.0,top:4.0),
                            entryTextStyle: charts.TextStyleSpec(
                                color: charts.MaterialPalette.purple.shadeDefault,
                                fontFamily: 'Georgia',
                                fontSize: 18),
                          )
                        ],
                        defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 60,
                            strokeWidthPx: troke,
                            startAngle:  9 / 7 * pi,
                            arcRendererDecorators: [

                              new charts.ArcLabelDecorator( insideLabelStyleSpec: new charts.TextStyleSpec(fontSize:12),
                                  showLeaderLines: true,
                                  labelPadding: 5 ,
                                  outsideLabelStyleSpec:  new charts.TextStyleSpec(fontSize:11),
                                  labelPosition: charts.ArcLabelPosition.auto),
                            ])),
                  )
                ),
              ],
            ),
          ),
        ),

    );





  }

  _change() {
    setState(() {
      if(troke==5.0){
        troke=0.0;
      }else{
        troke=5.0;
      }
    });
  }

}
