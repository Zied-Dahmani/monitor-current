import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/button.dart';
import 'package:pfe/widgets/logo.dart';
import 'package:pfe/widgets/text.dart';
import 'package:pfe/widgets/text_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe/utilities/globals.dart' ;
import '../machine/machines_screen.dart';
import 'forgotten_password_screen.dart';

class SignInScreen extends StatefulWidget {

  static String id='sign_in_screen';

  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _emailController = TextEditingController(), _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _data;

  @override
  void initState() {
      super.initState();
      getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kwhite,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Logo(),

                  SizedBox(height: 20),
                  TextFormFieldWidget(controller:_emailController,icon:Icons.email,labelText:"Email",hintText: "",
                      inputType: TextInputType.text),
                  SizedBox(height: 14),
                  TextFormFieldWidget(controller:_passwordController,icon:Icons.lock,labelText:"Mot de passe",hintText: "",
                      inputType: TextInputType.text,obscureText: true),

                  SizedBox(height: 40),
                  ButtonWidget(text: "Se Connecter",width: MediaQuery.of(context).size.width-80,fontsize: 16.0,function: () {
                   if (_formKey.currentState!.validate())
                     signIn();
                    }
                  ),
                  SizedBox(height: 20),
                  InkWell(
                      onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgottenPasswordScreen(usersList: _data)))
                          .then((value) => getData()),
                      child: TextWidget(text:"Mot de passe oublié?",color: kred,bold: false,size: 14.0,shadow: false)
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getData() async{
    final response = await http.post(Uri.parse('$url/users.php'),body: {});
    _data =json.decode(response.body);
  }

  Future<void> signIn() async
  {
    var _found = false;

    for(int  i=0;i< _data.length;i++)
      if(_data[i]['email']==_emailController.text&&_data[i]['mdp']==_passwordController.text)
      {
        _found=true;
        isAdmin=_data[i]['role']=="admin";
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('role',_data[i]['role']);
        prefs.setString('email',_data[i]['email']);
          Navigator.pushNamed(context,MachinesScreen.id);
      }

      if(!_found)
        ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text("Email ou mot de passe incorrect")));
  }

}
