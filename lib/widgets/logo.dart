import 'package:flutter/cupertino.dart';
import 'package:pfe/utilities/constants.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
      width: 160.0,
      height: 160.0,
      decoration: BoxDecoration(
        color: kwhite,
        image: DecorationImage(
          image: AssetImage('assets/appIcon.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all( Radius.circular(80.0)),
        border: Border.all(color: kblack, width: 2.0,),
      ),
    );
  }
}
