// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TextWidget extends StatelessWidget {

  const TextWidget({Key? key,this.text,this.color,this.bold,this.size,this.shadow}) : super(key: key);
  final text,color,bold,size,shadow;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontFamily: 'ZonaPro',fontWeight: bold?FontWeight.bold:FontWeight.normal,decoration: TextDecoration.none,
      fontSize: size,shadows: <Shadow>[
        if(shadow)
          Shadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 3.0,
            color: Color.fromARGB(200, 0, 0, 0),
          ),
        if(shadow)
          Shadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 8.0,
            color: Colors.black,
          ),
      ]
      ,)
    );
  }
}
