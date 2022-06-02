import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';

class BarChart {

  BarChart({required this.x, required this.value1, this.value2,this.value3,  required this.color});

  var x,value1,value2,value3;
  charts.Color color;

}