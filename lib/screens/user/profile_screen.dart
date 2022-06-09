import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/app_bar.dart';
import 'package:pfe/widgets/button.dart';
import 'package:pfe/widgets/text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {

  static String id='profile_screen';
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final _lastNameController = TextEditingController(),
      _firstNameController = TextEditingController(),
      _passwordController = TextEditingController();

  final _Formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child:AppBarWidget(title: "Profil")),
          backgroundColor: kwhite,
          body: Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Form(
                key: _Formkey,
                child: Column(
                  children: [

                    TextFormFieldWidget(controller:_lastNameController,icon:Icons.info,labelText:"Nom",hintText: "",
                        inputType: TextInputType.text),
                    SizedBox(height: 14),
                    TextFormFieldWidget(controller:_firstNameController,icon:Icons.info,labelText:"Prénom",hintText: "",
                        inputType: TextInputType.number),
                    SizedBox(height: 14),
                    TextFormFieldWidget(controller:_passwordController,icon:Icons.lock,labelText:"Mot de passe",hintText: "",
                        inputType: TextInputType.text,obscureText: true),

                    //SizedBox(height: 40),
                    Spacer(),
                    ButtonWidget(text: "Modifier",width: MediaQuery.of(context).size.width-80,fontsize: 16.0,function: ()
                    {
                      if(_Formkey.currentState!.validate())
                        editProfile();
                    }
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              )
          )
      );
  }

  getData() async
  {
    final prefs = await SharedPreferences.getInstance();


    final response = await http.post(Uri.parse('$url/users.php'),body: {});
    var data =json.decode(response.body);

    for(int  i=0;i< data.length;i++)
      if(data[i]['email']==prefs.getString('email'))
        setState(() {
          _firstNameController.text=data[i]['prénom'];
          _lastNameController.text=data[i]['nom'];
          _passwordController.text=data[i]['mdp'];
        });

  }

  Future editProfile() async {

    final prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');

    var data ={"email":email,"firstName":_firstNameController.text,"lastName":_lastNameController.text,"password":_passwordController.text};
    final response = await http.post(Uri.parse('$url/editUser.php'),body: data);

    var responseJson =json.decode(response.body);

    if(responseJson==1)
      Navigator.pop(context);
  }
}
