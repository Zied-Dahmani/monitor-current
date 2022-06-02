
import 'package:flutter/material.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/widgets/text.dart';

class AppBarWidget extends StatelessWidget {

  const AppBarWidget({Key? key, this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: kwhite,
        foregroundColor: kblack,
        elevation: 0,
        title: TextWidget(text:title,color: kblack,bold: true,size: 18.0,shadow: false)
    );
  }
}
