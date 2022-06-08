import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/app_bar.dart';
import 'package:pfe/widgets/button.dart';
import 'package:pfe/widgets/text_form_field.dart';
import 'package:http/http.dart' as http;

class AddEditControllerScreen extends StatefulWidget {

  static String id='add_edit_controller_screen';
  AddEditControllerScreen({Key? key, this.edit, this.controller}) : super(key: key);

  final edit,controller;

  @override
  State<AddEditControllerScreen> createState() => _AddEditControllerScreenState();
}

class _AddEditControllerScreenState extends State<AddEditControllerScreen> {

  final _emailController = TextEditingController(),
      _lastNameController = TextEditingController(),
      _firstNameController = TextEditingController(),
      _passwor1dController = TextEditingController(),
      _passwor2dController = TextEditingController();

  final _Formkey = GlobalKey<FormState>();

  var buttonText;

  @override
  void initState() {
    super.initState();
     buttonText=widget.edit?"Modifier":"Ajouter";
    if(widget.edit)
    {
      _lastNameController.text=widget.controller.getLastName();
      _firstNameController.text=widget.controller.getFirstName();
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child:AppBarWidget(title: "$buttonText un contrôleur")),
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

                      SizedBox(height: 14),
                      if(!widget.edit)
                        TextFormFieldWidget(controller:_emailController,icon:Icons.email,labelText:"Email",hintText: "",
                          inputType: TextInputType.text),
                      if(!widget.edit)
                        SizedBox(height: 14),
                      TextFormFieldWidget(controller:_lastNameController,icon:Icons.info,labelText:"Nom",hintText: "",
                          inputType: TextInputType.text),
                      SizedBox(height: 14),
                      TextFormFieldWidget(controller:_firstNameController,icon:Icons.info,labelText:"Prénom",hintText: "",
                          inputType: TextInputType.text),
                      if(!widget.edit)
                      SizedBox(height: 14),
                      if(!widget.edit)
                        TextFormFieldWidget(controller:_passwor1dController,icon:Icons.lock,labelText:"Mot de passe",hintText: "",
                          inputType: TextInputType.text,obscureText: true),
                      if(!widget.edit)
                        SizedBox(height: 14),
                      if(!widget.edit)
                        TextFormFieldWidget(controller:_passwor2dController,icon:Icons.lock,labelText:"Mot de passe",hintText: "",
                          inputType: TextInputType.text,obscureText: true),

                      SizedBox(height: 40),
                      ButtonWidget(text: buttonText,width: MediaQuery.of(context).size.width-80,fontsize: 16.0,function: ()
                      {
                        if (_Formkey.currentState!.validate())
                          if(buttonText=="Ajouter"&&_passwor1dController.text!=_passwor2dController.text)
                            ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text("Taper le même mot de passe!")));
                          else if(buttonText=="Ajouter") addController();
                          else editController();
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

  Future addController() async {

    var data ={"email":_emailController.text,"firstName":_firstNameController.text,"lastName":_lastNameController.text, "password": _passwor1dController.text};
    final response = await http.post(Uri.parse('$url/addController.php'),body: data);

    final responseJson = await json.decode(response.body);
    print(responseJson);

    if(responseJson==1)
      Navigator.pop(context);

  }

  Future editController() async {

    var data ={"email":widget.controller.getEmail(),"firstName":_firstNameController.text,"lastName":_lastNameController.text};
    final response = await http.post(Uri.parse('$url/editController.php'),body: data);

    var responseJson =json.decode(response.body);

    if(responseJson==1)
      {
        widget.controller.setFirstName(_firstNameController.text);
        widget.controller.setLastName(_lastNameController.text);
        Navigator.pop(context);
      }

  }

}
