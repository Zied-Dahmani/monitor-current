import 'package:flutter/cupertino.dart';
import '../text.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({Key? key,this.icon,this.color,this.text,this.function}) : super(key: key);

  final icon,color,text,function;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        GestureDetector(
          onTap:(){if(function!=null) function();} ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon,size: 26.0,color: color,),
              SizedBox(width: 5,),
              TextWidget(text: text,color: color,bold: false,size: 16.0,shadow: false,),
            ],
          ),
        ),
      ],
    );
  }
}


