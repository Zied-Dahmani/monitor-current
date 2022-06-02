// ignore_for_file: prefer_const_constructors, prefer_final_fields, curly_braces_in_flow_control_structures
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe/models/Machine.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/utilities/globals.dart';
import 'package:pfe/widgets/drawer/drawer.dart';
import 'package:pfe/widgets/home_app_bar.dart';
import 'package:pfe/widgets/machine_card.dart';
import 'package:pfe/widgets/text_form_field.dart';
import 'package:http/http.dart' as http;
import 'add_machine_screen.dart';
import 'results_screen.dart';

class MachinesScreen extends StatefulWidget {

  static String id='machines_screen';
  const MachinesScreen({Key? key}) : super(key: key);

  @override
  _MachinesScreenState createState() => _MachinesScreenState();
}

class _MachinesScreenState extends State<MachinesScreen> {

  final _searchController = TextEditingController();

  var _machinesList=[],_resultsList = [];

  @override
  void initState() {
    super.initState();
    getMachines();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: Homeappbar(title: "Machines"),
        drawer: DrawerWidget(),
        backgroundColor: kwhite,
        body: Container(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormFieldWidget(controller:_searchController,icon:Icons.search,labelText:"Trouver une machine...",hintText: "Trouver une machine...",
                  inputType: TextInputType.text, function : () => setState(() {searchResultsList();}),
                ),
              ),

              SizedBox(height: 40),

              _resultsList.isNotEmpty?
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (
                      OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                    return true;
                  },
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                      itemCount: _resultsList.length,
                      itemBuilder: (context, i) {
                        return   Column(
                          children: [
                            SizedBox(height: 34),
                            MachineCard(width: MediaQuery.of(context).size.width,height: 160.0,machine: _resultsList[i],function: ()=>
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsScreen(machine: _resultsList[i])))
                                    .then((value) => getMachines())),
                            SizedBox(height: 26)
                          ],
                        );
                      }
                  ),
                ),
              ):
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Center(child: CircularProgressIndicator(color: kred)),
              )

            ],
          ),
        ),
        floatingActionButton: floatingButton()
      ),
    );
  }

  Widget floatingButton() {

    return isAdmin?
    FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context,AddMachineScreen.id),
      child: Icon(Icons.add),
      backgroundColor: kred,
    ): SizedBox();
  }

  Future<void> getMachines() async
  {
    _machinesList=[];
    final response = await http.post(Uri.parse('$url/machines.php'),body: {});
    var data =json.decode(response.body);

    for(int  i=0;i< data.length;i++)
    {
      setState(() {
        _machinesList.add(Machine(data[i]['id'], data[i]['nom'],data[i]['courant'],data[i]['temperature_max'],data[i]['temperature_min'], data[i]['image']));
      });
    }
    searchResultsList();
  }

  searchResultsList() {
    List<Machine> showResults = [];
    _resultsList=[];

    if(_searchController.text != "") {
      for(var tripSnapshot in _machinesList){
        var name = tripSnapshot.getName().toLowerCase();
        if( name.contains(_searchController.text.toLowerCase()) )
        {
          showResults.add(tripSnapshot);
        }
      }
    } else {
      showResults = List.from(_machinesList);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

}
