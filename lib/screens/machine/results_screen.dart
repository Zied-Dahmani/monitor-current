import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe/models/Alert.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/utilities/globals.dart';
import 'package:pfe/widgets/app_bar.dart';
import 'package:pfe/widgets/text.dart';
import 'package:http/http.dart' as http;
import 'history/history_screen.dart';
import 'settings_screen.dart';

class ResultsScreen extends StatefulWidget {

  ResultsScreen({Key? key, this.machine}) : super(key: key);

  final machine;

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {

  var _alertsList=[],_power1="",_power2="",_power3="",_temperature="",_humidity="";

  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child: AppBarWidget(title: "Résultats")),
      backgroundColor: kwhite,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.electrical_services,color: kred,size: 28),
                SizedBox(width: 4),
                TextWidget(text:"Courant:",color: kblack,bold: false,size: 16.0,shadow: false),
                Spacer(),
                TextWidget(text:"$_power1 A  $_power2 A  $_power3 A",color: kblack,bold: false,size: 16.0,shadow: false)
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.whatshot,color: kred,size: 28),
                SizedBox(width: 4),
                TextWidget(text:"Température:",color: kblack,bold: false,size: 16.0,shadow: false),
                Spacer(),
                TextWidget(text:"$_temperature °C",color: kblack,bold: false,size: 16.0,shadow: false)
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.cloud,color: kred,size: 28),
                SizedBox(width: 4),
                TextWidget(text:"Humidité:",color: kblack,bold: false,size: 16.0,shadow: false),
                Spacer(),
                TextWidget(text:"$_humidity %",color: kblack,bold: false,size: 16.0,shadow: false)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.battery_alert,color: kred,size: 28),
                TextWidget(text:"Alertes",color: kblack,bold: true,size: 16.0,shadow: false),
              ],
            ),

            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (
                    OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                    itemCount: _alertsList.length,
                    itemBuilder: (context, i) {
                      return   Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(text:_alertsList[i].getId(),color: kblack,bold: true,size: 16.0,shadow: false),
                              SizedBox(width: 8),
                              TextWidget(text:_alertsList[i].getDate(),color: kblack,bold: true,size: 16.0,shadow: false),
                              SizedBox(width: 8),
                              TextWidget(text:_alertsList[i].getTime(),color: kblack,bold: true,size: 16.0,shadow: false),
                              SizedBox(width: 8),
                              TextWidget(text:_alertsList[i].getType(),color: kblack,bold: true,size: 16.0,shadow: false),
                              SizedBox(width: 8),
                            ],
                          ),
                        ],
                      );
                    }
                ),
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
              child: FloatingActionButton(
                heroTag: "btn1",
                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen(machine: widget.machine))),
                backgroundColor: kred,
                child: Icon(Icons.history_outlined),
              )
          ),
          SizedBox(height: 10),
          if(isAdmin)
          Container(
               child: FloatingActionButton(
                 heroTag: "btn2",
                 onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(machine: widget.machine))),
                 backgroundColor: kred,
                 child: Icon(Icons.settings),
              )
          ),
        ],
      ),
    );
  }

  Future<void> getData() async
  {
    final response1 = await http.post(Uri.parse('$url/powers.php'),body: {'machineId':widget.machine.getId()});
    var data1 =json.decode(response1.body);
    final response2 = await http.post(Uri.parse('$url/temperatures.php'),body: {'machineId':widget.machine.getId()});
    var data2 =json.decode(response2.body);
    final response3 = await http.post(Uri.parse('$url/humidity.php'),body: {'machineId':widget.machine.getId()});
    var data3 =json.decode(response3.body);

    for(int i=data1.length-1;i>=0;i--)
      {
        if(data1[i]['machine_id']==widget.machine.getId())
          {
            _power1=data1[i]['valeur1'];
            _power2=data1[i]['valeur2'];
            _power3=data1[i]['valeur3'];
            i=-1;
          }
      }
    for(int i=data2.length-1;i>=0;i--)
    {
      if(data2[i]['machine_id']==widget.machine.getId())
      {
        _temperature=data2[i]['valeur'];
        i=-1;
      }
    }
    for(int i=data3.length-1;i>=0;i--)
    {
      if(data3[i]['machine_id']==widget.machine.getId())
      {
        _humidity=data3[data3.length-1]['valeur'];
        i=-1;
      }
    }
    if (mounted)
    setState(() {});

    _alertsList=[];
    final response4 = await http.post(Uri.parse('$url/alerts.php'),body: {});
    var data4 =json.decode(response4.body);

    for(int  i=0; i< data4.length;i++)
    {
      if (mounted&&data4[i]['machine_id']==widget.machine.getId())
      setState(() {
        _alertsList.add(Alert(data4[i]['id'], data4[i]['date'], data4[i]['heure'],data4[i]['type']));
      });
    }

    Future.delayed(const Duration(milliseconds: 5000), () async => getData() );
  }


}
