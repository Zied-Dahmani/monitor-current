import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pfe/models/Alert.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:http/http.dart' as http;

class AlertsScreen extends StatefulWidget {

  const AlertsScreen({Key? key, this.machineId}) : super(key: key);
  final machineId;

  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {

  var _alertsList=[];

  @override
  void initState() {
    super.initState();
    getAlertes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kwhite,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            DataTable(
              columns: const [
                DataColumn(label: Text('ID', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Heure', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Type', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
              ],
              rows: [
                for(int i=0;i<_alertsList.length;i++)
                  DataRow(cells: [
                    DataCell(Text(_alertsList[i].getId(),style: TextStyle(fontSize: 12))),
                    DataCell(Text(_alertsList[i].getDate(),style: TextStyle(fontSize: 12))),
                    DataCell(Text(_alertsList[i].getTime(),style: TextStyle(fontSize: 12))),
                    DataCell(Text(_alertsList[i].getType(),style: TextStyle(fontSize: 12))),
                  ]
                  ),
              ],
            ),
          ]
        ),
      ),
    );
  }

  Future<void> getAlertes() async
  {
    final response = await http.post(Uri.parse('$url/alerts.php'),body: {'machineId':widget.machineId});
    var data =json.decode(response.body);

    for(int  i=0;i< data.length;i++)
    {
      if (mounted&&data[i]['machine_id']==widget.machineId)
        setState(() {
        _alertsList.add(Alert(data[i]['id'], data[i]['date'], data[i]['heure'],data[i]['type']));
      });
    }
  }

}
