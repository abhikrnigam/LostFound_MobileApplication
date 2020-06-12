import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/LoginScreen.dart';
import 'package:lostfound/MainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn;

  void getprefs() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    loggedIn=preferences.getBool("isLoggedIn");
  }


   Widget getWidget(){
    if(loggedIn==null){
      return LoginScreen();
    }
    else if(loggedIn){
     return MainScreen();
    }
    else{
      return LoginScreen();
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefs();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
              accentColorBrightness: Brightness.dark,
      ),
      home: getWidget(),
    );

  }
}

