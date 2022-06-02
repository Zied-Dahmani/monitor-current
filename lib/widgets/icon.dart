// ignore_for_file: unnecessary_new
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {

  const IconWidget({Key? key,this.icon,this.color,this.backgroundColor,this.function, this.radius,}) : super(key: key);
  final icon,function,backgroundColor,color,radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: backgroundColor,
          borderRadius: new BorderRadius.all(Radius.circular(radius??25),)
      ),
      child: IconButton(
          icon: Icon(icon,
            color: color,
          ),
          onPressed: ()=> function()
      ),
    );
  }
}
