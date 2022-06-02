import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/text.dart';

import 'icon.dart';

class Homeappbar extends StatelessWidget with PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(80);
  const Homeappbar({Key? key,this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kwhite,
      brightness: Brightness.dark,
      elevation: 0,
      title: Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/4),
        child: TextWidget(text:title,color: kblack,bold: true,size: 20.0,shadow: false,),),
      leading: Padding(
          padding: EdgeInsets.only(top: 10,left: 10),
          child: IconWidget(icon:Icons.table_rows_rounded,color:kblack,backgroundColor:klightGrey ,function: ()=>Scaffold.of(context).openDrawer(),
          )
      ),
    );
  }

}
