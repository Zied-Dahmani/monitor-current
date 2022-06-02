import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pfe/models/BarChart.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartWidget extends StatelessWidget {

  ChartWidget({Key? key, required this.data,required this.fileName}) : super(key: key);

  // BarChart -> Model
  final List<BarChart> data;
  final fileName;
  var series;



  @override
  Widget build(BuildContext context) {

    if(fileName!="powers")
      series = [
        charts.Series(
            id: "chart",
            data: data,
            domainFn: (BarChart series, _) => series.x.toString(),
            measureFn: (BarChart series, _) => series.value1,
            colorFn: (BarChart series, _) => series.color),

    ];

   return fileName!="powers"?charts.BarChart(series,animate: true):
   Container(
       child: SfCartesianChart(
          enableAxisAnimation: true,
           primaryXAxis: CategoryAxis(),
           series: <CartesianSeries>[
             ColumnSeries<BarChart, String>(
                 dataSource: data,
                 xValueMapper: (BarChart data, _) => data.x,
                 yValueMapper: (BarChart data, _) => data.value1,
                 pointColorMapper: (BarChart data, _) => kred,
    ),
             ColumnSeries<BarChart, String>(
                 dataSource: data,
                 xValueMapper: (BarChart data, _) => data.x,
                 yValueMapper: (BarChart data, _) => data.value2,
                 pointColorMapper: (BarChart data, _) => Colors.blue
   ),
             ColumnSeries<BarChart, String>(
                 dataSource: data,
                 xValueMapper: (BarChart data, _) => data.x,
                 yValueMapper: (BarChart data, _) => data.value3,
                 pointColorMapper: (BarChart data, _) => kblack
             )
           ]
       )
   );
  }
}
