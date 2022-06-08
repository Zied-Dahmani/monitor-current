import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/app_bar.dart';
import 'package:pfe/widgets/button.dart';
import 'package:pfe/widgets/text_form_field.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, this.machine}) : super(key: key);

  final machine;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  var _nameController, _powerController , _maxTemperatureController , _minTemperatureController;
  final _Formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text:widget.machine.getName());
    _powerController = TextEditingController(text: widget.machine.getPower());
    _maxTemperatureController = TextEditingController(text: widget.machine.getMaxTemperature());
    _minTemperatureController = TextEditingController(text: widget.machine.getMinTemperature());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child:AppBarWidget(title: "Réglages")),
        backgroundColor: kwhite,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Form(
            key: _Formkey,
            child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network("$url/uploads/${widget.machine.getImage()}",height: 180,width: 180),
                  SizedBox(height: 16),
                  TextFormFieldWidget(controller:_nameController,icon:Icons.info,labelText:"Nom",hintText: "",
                    inputType: TextInputType.text),
                  SizedBox(height: 14),
                  TextFormFieldWidget(controller:_powerController,icon:Icons.electrical_services,labelText:"Courant",hintText: "",
                      inputType: TextInputType.text),
                  SizedBox(height: 14),
                  TextFormFieldWidget(controller:_maxTemperatureController,icon:Icons.whatshot,labelText:"Température Max",hintText: "",
                      inputType: TextInputType.number),
                  SizedBox(height: 14),
                  TextFormFieldWidget(controller:_minTemperatureController,icon:Icons.whatshot,labelText:"Température Min",hintText: "",
                      inputType: TextInputType.number),

                  SizedBox(height: 40),
                  ButtonWidget(text: "Modifier",width: MediaQuery.of(context).size.width-80,fontsize: 16.0,function: ()
                  {
                    if(_Formkey.currentState!.validate())
                      editMachine();
                  }
                  ),
                ],
              ),
            ),
          ),
          )
        )
    );
  }

  Future editMachine() async {

    var data ={"id":widget.machine.getId(),"name":_nameController.text,"power":_powerController.text,"maxTemperature":_maxTemperatureController.text,
    "minTemperature":_minTemperatureController.text};

    final response = await http.post(Uri.parse('$url/editMachine.php'),body: data);

    var responseJson =json.decode(response.body);

    if(responseJson==1)
      {
        widget.machine.setName(_nameController.text);
        widget.machine.setPower(_powerController.text);
        widget.machine.setMaxTemperature(_maxTemperatureController.text);
        widget.machine.setMinTemperature(_minTemperatureController.text);
        Navigator.pop(context);
      }
  }
}
