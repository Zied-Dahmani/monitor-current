// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/app_bar.dart';
import 'package:pfe/widgets/button.dart';
import 'package:pfe/widgets/text_form_field.dart';
import 'package:http/http.dart' as http;

import 'machines_screen.dart';

class AddMachineScreen extends StatefulWidget {

  static String id='add_machine_screen';
  AddMachineScreen({Key? key}) : super(key: key);

  @override
  State<AddMachineScreen> createState() => _AddMachineScreenState();
}

class _AddMachineScreenState extends State<AddMachineScreen> {
  final _nameController = TextEditingController(),
      _powerController = TextEditingController(),
      _maxTemperatureController = TextEditingController(),
      _minTemperatureController = TextEditingController(),
      _inputsController=TextEditingController();

  final _formKey = GlobalKey<FormState>();


  var _image;
  final picker = ImagePicker();

  Future pickImage()async{
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
    _image=File(pickedImage!.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child:AppBarWidget(title: "Ajouter une machine")),
      backgroundColor: kwhite,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Form(
          key: _formKey,
          child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [

                GestureDetector(
                  onTap: ()=> pickImage(),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: _image==null?klightGrey:kwhite, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child:  _image==null?Icon(Icons.add,size: 40):Image.file(_image,fit: BoxFit.fitHeight)
                  ),
                ),


                SizedBox(height: 14),
                TextFormFieldWidget(controller:_nameController,icon:Icons.info,labelText:"Nom",hintText: "",
                    inputType: TextInputType.text),
                SizedBox(height: 14),
                TextFormFieldWidget(controller:_powerController,icon:Icons.electrical_services,labelText:"Courant",hintText: "",
                    inputType: TextInputType.number),
                SizedBox(height: 14),
                TextFormFieldWidget(controller:_maxTemperatureController,icon:Icons.whatshot,labelText:"Température Max",hintText: "",
                    inputType: TextInputType.number),
                SizedBox(height: 14),
                TextFormFieldWidget(controller:_minTemperatureController,icon:Icons.whatshot,labelText:"Température Min",hintText: "",
                    inputType: TextInputType.number),

                SizedBox(height: 14),
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: klightGrey, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child:  ConstrainedBox(constraints: BoxConstraints(maxHeight: 200.0,),
                    child:  Scrollbar(
                      child:  SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          height: 200.0,
                          child: TextField(
                            cursorColor: kblack,
                            controller: _inputsController,
                            maxLines: 100,
                            decoration: new InputDecoration(border: InputBorder.none, hintText: "Autre"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),
                ButtonWidget(text: "Ajouter",width: MediaQuery.of(context).size.width-80,fontsize: 16.0,
                    function: () {
                      if (_formKey.currentState!.validate()) addMachine();
                    }
                ),
                SizedBox(height: 20)

              ],
            ),
          ),
        ),
      ),
      )
    );
  }

  Future addMachine() async {
    if(_image==null) return;

    String base64 = base64Encode(_image.readAsBytesSync());
    String imageName =_image.path.split("/").last;

    var data ={"name":_nameController.text,"power":_powerController.text,"maxTemperature":_maxTemperatureController.text,"minTemperature":_minTemperatureController.text,
      "description":_inputsController.text,"imagename": imageName,"image64":base64};
    final response = await http.post(Uri.parse('$url/addMachine.php'),body: data);

    final responseJson = await json.decode(json.encode(response.body));

    if(responseJson=="success")
      Navigator.pushNamed(context,MachinesScreen.id);

  }

}
