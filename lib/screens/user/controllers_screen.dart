// ignore_for_file: prefer_const_constructors, prefer_final_fields, curly_braces_in_flow_control_structures
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe/models/User.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:pfe/widgets/text.dart';

import 'add__edit_controller_screen.dart';

class ControllersScreen extends StatefulWidget {

  static String id='controllers_screen';
  const ControllersScreen({Key? key}) : super(key: key);

  @override
  _ControllersScreenState createState() => _ControllersScreenState();
}

class _ControllersScreenState extends State<ControllersScreen> {


  var _controllersList=[];

  @override
  void initState() {
    super.initState();
    getControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child:AppBarWidget(title: "Contrôleurs")),
      backgroundColor: kwhite,
      body: Container(
        child: Column(
          children: [

            _controllersList.isNotEmpty?
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (
                    OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                    itemCount: _controllersList.length,
                    itemBuilder: (context, i) {
                      return   InkWell(
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditControllerScreen(edit:true,controller:_controllersList[i],)))
                            .then((_) =>setState(() {}) ),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),

                              Row(
                                children: [
                                  Icon(Icons.person,size: 26),
                                  SizedBox(width: 14),
                                  TextWidget(text:_controllersList[i].getLastName(),color: kblack,bold: false,size: 16.0,shadow: false),
                                  SizedBox(width: 6),
                                  TextWidget(text:_controllersList[i].getFirstName(),color: kblack,bold: false,size: 16.0,shadow: false),
                                ],
                              ),
                              SizedBox(height: 14),
                              Row(
                                children: [
                                  Icon(Icons.email,size: 24),
                                  SizedBox(width: 14),
                                  TextWidget(text:_controllersList[i].getEmail(),color: kblack,bold: false,size: 16.0,shadow: false),
                                  Spacer(),
                                  IconButton(onPressed: () => removeController(i), icon: Icon(Icons.delete,size: 24,color: kred))
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                        ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditControllerScreen(edit: false, controller: null)))
            .then((_) => getControllers()),
        child: Icon(Icons.add),
        backgroundColor: kred,
      ),
    );
  }

  Future<void> getControllers() async
  {
    _controllersList=[];

    final response = await http.post(Uri.parse('$url/controllers.php'),body: {});
    var data =json.decode(response.body);


    for(int  i=0;i< data.length;i++)
    {
      setState(() {
        _controllersList.add(User(data[i]['email'], data[i]['nom'], data[i]['prénom']));
      });
    }
  }


  Future<void> removeController(index)  async {
    final response = await http.post(Uri.parse('$url/deleteController.php'),body: {"email":_controllersList[index].getEmail()});
    var data =json.decode(response.body);

    if(data ==1)
      setState(() {
        _controllersList.removeAt(index);
      });
  }

}
