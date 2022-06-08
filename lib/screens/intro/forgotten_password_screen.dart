// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/app_bar.dart';
import 'package:pfe/widgets/button.dart';
import 'package:pfe/widgets/logo.dart';
import 'package:pfe/widgets/text_form_field.dart';
import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

class ForgottenPasswordScreen extends StatefulWidget {

  static String id='forgotten_password_screen';
  ForgottenPasswordScreen({Key? key, this.usersList}) : super(key: key);

  final usersList;

  @override
  State<ForgottenPasswordScreen> createState() => _ForgottenPasswordScreenState();
}

class _ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {


  final _emailController = TextEditingController(), _codeController = TextEditingController(),_password1Controller = TextEditingController(),_password2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _found = false,_password=false,_code;

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child:AppBarWidget(title: "")),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child:  Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                Logo(),

                SizedBox(height: 14),
                if(_password)
                  TextFormFieldWidget(controller:_password1Controller,icon:Icons.lock,labelText:"Mot de passe",hintText: "",
                    inputType: TextInputType.text,obscureText: true),
                if(_password)
                  SizedBox(height: 14),
                if(_password)
                  TextFormFieldWidget(controller:_password2Controller,icon:Icons.lock,labelText:"Mot de passe",hintText: "",
                    inputType: TextInputType.text,obscureText: true),

                if(_found&&!_password)
                  TextFormFieldWidget(controller:_codeController,icon:Icons.info,labelText:"Code",hintText: "",
                    inputType: TextInputType.text),
                if(!_found&&!_password)
                  TextFormFieldWidget(controller:_emailController,icon:Icons.email,labelText:"Email",hintText: "",
                    inputType: TextInputType.text),

                SizedBox(height: 40),
                ButtonWidget(text: "Envoyer",width: MediaQuery.of(context).size.width-80,fontsize: 16.0,function: () {
                  if (_formKey.currentState!.validate())
                        _password?
                        resetPassword(_password1Controller.text,_password2Controller.text)
                        : _found?
                                (_codeController.text==_code)?
                                setState(() {
                                  _password=true;
                                })
                                :ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text("Le code est incorrect")))
                        :verify(_emailController.text);
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  verify(email) async {

    _found = false;

     try {
       for (int i = 0; i < widget.usersList.length; i++)
         if (widget.usersList[i]['email'] == email) {
           _code = getRandomString(5);
           setState(() {
             _found = true;
           });
           ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text("Vérifiez votre e-mail")));

           final smtpServer = gmail("ghub2441@gmail.com", "curvanordallez");

           final equivalentMessage = Message()
             ..from = Address("ghub2441@gmail.com", 'Monitor Current')
             ..recipients.add(Address(email))
             ..subject = 'Mot de passe oublié'
             ..text = 'Le code est $_code';

           final sendReport2 = await send(equivalentMessage, smtpServer);
           var connection = PersistentConnection(smtpServer);
           await connection.send(equivalentMessage);
           await connection.close();

         }
     }catch(e)
    {
      print(e);
    }

    if(!_found)
      ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text("L'email n'existe pas")));
  }

  resetPassword(password1,password2) async {

    if(password1!=password2)
      {
          ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text("Tapez le même mot de passe!")));
          return ;
      }

    var data ={"email":_emailController.text,"password":password1};
    final response = await http.post(Uri.parse('$url/resetPassword.php'),body: data);
    var responseJson =json.decode(response.body);

    if(responseJson==1)
      {
        ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text("Mot de passe modifié")));
        Navigator.pop(context);
      }
  }

}
