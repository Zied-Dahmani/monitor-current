// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/utilities/constants.dart';

import 'button.dart';
import 'text.dart';

class MachineCard extends StatefulWidget {

  MachineCard({Key? key,this.machine,this.height,this.width, this.function}) : super(key: key);
  final machine,height,width,function;

  @override
  State<MachineCard> createState() => _MachineCardState();
}

class _MachineCardState extends State<MachineCard> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15,top: 15),
          decoration: BoxDecoration(color: kwhite, borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: kgrey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: widget.height,
          width: widget.width,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: TextWidget(text:widget.machine.getName(),color: kblack,bold: true,size: 18.0,shadow: false,),
              ),
              Spacer(),
              ButtonWidget(text: "Configuration",function: ()=>widget.function())
            ],
          ),
        ),
          Positioned(
          left: 14,
          bottom: 70,
            child:  Image.network("$url/uploads/${widget.machine.getImage()}",height: 140,width: 140),
          ),
        ]
    );
  }
}
