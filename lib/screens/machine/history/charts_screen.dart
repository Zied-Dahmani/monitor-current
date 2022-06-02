import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe/models/BarChart.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;


class ChartsScreen extends StatefulWidget {

  ChartsScreen({Key? key, this.machineId, this.fileName}) : super(key: key);

  final machineId,fileName;

  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}


class _ChartsScreenState extends State<ChartsScreen> {

  List<BarChart> list =[];


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) => ChartWidget(data: list,fileName: widget.fileName);


  Future<void> getData() async
  {
    var nb=0;
    final response = await http.post(Uri.parse('$url/${widget.fileName}.php'),body: {'machineId':widget.machineId});
    var data =json.decode(response.body);
    var b ;

    for(int i=data.length-1; i>= 0; i--) {
      if (data[i]['machine_id'] == widget.machineId && nb<4) {
        if (widget.fileName == "powers")
          b = BarChart(x: data[i]['date'],
            value1: int.parse(data[i]['valeur1']),
            value2: int.parse(data[i]['valeur2']),
            value3: int.parse(data[i]['valeur3']),
            color: charts.ColorUtil.fromDartColor(kred),);
        else
          b = BarChart(x: data[i]['date'],
              value1: int.parse(data[i]['valeur']),
              color: charts.ColorUtil.fromDartColor(kred));

        setState(() {
          list.add(b);
          nb++;
        });
      }
    }
  }

}
