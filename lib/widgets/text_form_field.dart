// ignore_for_file: unnecessary_new, use_key_in_widget_constructors, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_typing_uninitialized_variables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/utilities/constants.dart';

class TextFormFieldWidget extends StatefulWidget {

  TextFormFieldWidget({Key? key,this.controller, this.icon, this.labelText,this.hintText,this.inputType,this.function, this.obscureText}) : super(key: key);
  final controller,icon,labelText,hintText,inputType,function,obscureText;

  @override
  // ignore: no_logic_in_create_state
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: widget.controller,
        // ignore: missing_return
        validator: (val) {
          if(val!.isEmpty)
            switch(widget.labelText)
          {
            case "Email": return "Tapez votre email!";
            case "Mot de passe": return "Tapez votre mote de passe!";
            case "Nom":  return "Tapez le nom!";
            case "Courant":  return "Tapez le courant!";
            case "Code": return "Tapez le code!";
            default : return "Tapez la température!";
          }
          else if(widget.labelText=="Email"&& !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val))
            return "Tapez un email valide!";
        },
        onChanged: (text) => widget.hintText!=""?widget.function():true,
        cursorColor: kblack,
        keyboardType: widget.inputType,
        decoration: new InputDecoration(
          floatingLabelBehavior: widget.hintText!=""?FloatingLabelBehavior.never:FloatingLabelBehavior.auto,
          errorStyle: TextStyle(
              color: kred,
              fontSize: 12,
              fontWeight: FontWeight.bold),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kred, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kblack, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
              BorderSide(color: kblack, width: 2.0)),
          prefixIcon: Icon(
            widget.icon,
            color: kblack,
          ),
          hintText: widget.hintText,
          hintStyle:  TextStyle(fontSize: 14.0, color: kgrey),
          labelText: widget.labelText,
          labelStyle: TextStyle(fontSize: widget.hintText!=""?14.0:16.0, color: widget.hintText!=""?kgrey:kblack),
        ),
        style: TextStyle(
          color: kblack,
        ),
        obscureText: widget.obscureText??false,
      ),
    );
  }
}
