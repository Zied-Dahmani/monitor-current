import 'package:flutter/material.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/app_bar.dart';
import 'package:pfe/widgets/text.dart';

import 'alerts_screen.dart';
import 'charts_screen.dart';

class HistoryScreen extends StatefulWidget {

  const HistoryScreen({Key? key, this.machine}) : super(key: key);
  final machine;

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child:AppBarWidget(title: "Historique")),
        backgroundColor: kwhite,
        body: Column(
          children: <Widget>[

            Image.network("$url/uploads/${widget.machine.getImage()}",height: 180,width: 180),
            SizedBox(height: 14),
            TextWidget(text:widget.machine.getName(),color: kblack,bold: true,size: 18.0,shadow: false),
            SizedBox(height: 40),

            TabBar(
              isScrollable: true,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.8,color: kred),
              ),
              indicatorWeight: 8,
              tabs: [
                TextWidget(text: "Courant",color: kblack,bold: false,size: 14.0,shadow: false,),
                TextWidget(text: "Température",color: kblack,bold: false,size: 14.0,shadow: false,),
                TextWidget(text: "Humidité",color: kblack,bold: false,size: 14.0,shadow: false,),
                TextWidget(text: "Alertes",color: kblack,bold: false,size: 14.0,shadow: false,),
              ],
            ),

            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (
                    OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: TabBarView(
                  children: [
                    ChartsScreen(machineId: widget.machine.getId(),fileName:"powers"),
                    ChartsScreen(machineId: widget.machine.getId(),fileName:"temperatures"),
                    ChartsScreen(machineId: widget.machine.getId(),fileName:"humidity"),
                    AlertsScreen(machineId: widget.machine.getId()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
