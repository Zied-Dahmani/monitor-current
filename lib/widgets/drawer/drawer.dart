// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfe/screens/intro/sign_in_screen.dart';
import 'package:pfe/screens/user/controllers_screen.dart';
import 'package:pfe/screens/user/profile_screen.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:pfe/utilities/globals.dart' ;
import 'package:shared_preferences/shared_preferences.dart';
import '../icon.dart';
import 'drawer_list_tile.dart';

class DrawerWidget extends StatelessWidget {

  const DrawerWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kwhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.only(top: 60,left: 20,bottom: 20),
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                color: kwhite,
                image: DecorationImage(
                  image: AssetImage('assets/appIcon.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all( Radius.circular(60.0)),
                border: Border.all(color: kblack, width: 2.0,
                ),
              ),
            ),

            Divider(color: klightGrey,thickness: 2),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: kwhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  DrawerListTile(icon: Icons.person, color: kblack, text: "Profil", function: () => Navigator.pushNamed(context,ProfileScreen.id)),

                  if(isAdmin)
                  DrawerListTile(icon: Icons.people, color: kblack, text: "Contrôleurs", function: () => Navigator.pushNamed(context,ControllersScreen.id)),

                  DrawerListTile(icon: Icons.logout, color: kblack, text: "Se Déconnecter",
                    function: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('role','');
                      prefs.setString('email','');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                    },
                  ),
                ],
              )
              ),

            Spacer(),
            Divider(color: klightGrey,thickness: 2,),
            Container(
              padding: EdgeInsets.only(top: 10,bottom: 10),
              color: kwhite,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconWidget(icon:Icons.email_rounded,color:kblack,backgroundColor:klightGrey ,function: ()=>null),
                      SizedBox(width: 5),
                      IconWidget(icon:Icons.facebook,color:kblack,backgroundColor:klightGrey ,function: ()=>null),
                      SizedBox(width: 5),
                      IconWidget(icon:FontAwesomeIcons.instagram,color:kblack,backgroundColor:klightGrey ,function: ()=>null),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}


