import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/utilities/constants.dart';
import 'text.dart';


class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, this.text, this.function, this.width, this.fontsize}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final text,function,width,fontsize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: 50.0,
          width: width,
          child: RaisedButton(
            child: TextWidget(text: text,color: kwhite,bold: true,size: fontsize??14.0,shadow: false),
            color: kred,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(30.0),bottomRight:Radius.circular(30.0))),
            onPressed: ()=>function(),
          ),
        );
  }
}
