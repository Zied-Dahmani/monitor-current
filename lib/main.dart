// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe/screens/intro/splash_screen.dart';
import 'package:pfe/screens/machine/machines_screen.dart';
import 'package:pfe/screens/user/add__edit_controller_screen.dart';
import 'package:pfe/screens/user/controllers_screen.dart';
import 'package:pfe/screens/user/profile_screen.dart';
import 'screens/machine/add_machine_screen.dart';
import 'screens/intro/sign_in_screen.dart';
import 'utilities/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: kwhite,
            statusBarIconBrightness: Brightness.dark
        )
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      //showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      title: 'Monitor Current',
      initialRoute: SplashScreen.id,
      routes: <String, WidgetBuilder>{
        SplashScreen.id:(context)=> SplashScreen(),
        SignInScreen.id:(context)=> SignInScreen(),
        MachinesScreen.id:(context)=> MachinesScreen(),
        AddMachineScreen.id:(context)=> AddMachineScreen(),
        ProfileScreen.id:(context)=> ProfileScreen(),
        AddEditControllerScreen.id:(context)=> AddEditControllerScreen(),
        ControllersScreen.id:(context)=> ControllersScreen(),
      },
    );
  }
}

