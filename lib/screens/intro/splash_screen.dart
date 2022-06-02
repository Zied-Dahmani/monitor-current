import 'package:flutter/material.dart';
import 'package:pfe/screens/intro/sign_in_screen.dart';
import 'package:pfe/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pfe/utilities/globals.dart' ;
import '../machine/machines_screen.dart';

class SplashScreen extends StatefulWidget {

  static String id='splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    nav();
  }

  @override
  Widget build(BuildContext context) =>
      WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: kwhite,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child:Padding(
                padding: const EdgeInsets.only(right: 12.0,top: 10),
                child: Image.asset('assets/appIcon.jpg',width: 200,height: 200),
              ),
            ),
          ),
        ),
      );

  nav()
  {
    Future.delayed(const Duration(milliseconds: 2000), () async {

      final prefs = await SharedPreferences.getInstance();
      final String? role = prefs.getString('role');

      if(role=="admin"||role=="contrôleur")
        {
          isAdmin=role=="admin";
          Navigator.pushNamed(context,MachinesScreen.id);

        }
      else  Navigator.pushNamed(context,SignInScreen.id);

    });
  }


}
