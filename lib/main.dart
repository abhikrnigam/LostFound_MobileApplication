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


  Future<bool> getprefs() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    bool loggedIn=preferences.getBool("isLoggedIn");
    if(loggedIn==null){
      loggedIn=false;
    }
    return loggedIn;
  }
//Widget fuck(){
//    return FutureBuilder(
//      future: getprefs(),
//      builder: (context,snapshot){
//        if(!snapshot.hasData){
//          return Container();
//        }
//        else{
//          if(snapshot.data==true){
//            return QuoteScreen();
//          }
//          else{
//            return OngoingScreen();
//          }
//        }
//      },
//    );
//}





@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
              accentColorBrightness: Brightness.dark,
      ),
      home: FutureBuilder(
        future: getprefs(),
        // ignore: missing_return
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          else if(snapshot.data==true){
            return MainScreen();
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
          }
          else{
            return LoginScreen();
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          }
        },
      ),
    );

  }
}

