import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/LostForm.dart';
import 'package:lostfound/FoundForm.dart';
import 'package:lostfound/ExploreScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MainScreen extends StatelessWidget {

  FirebaseAuth auth=FirebaseAuth.instance;
  void logout() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", false);
  }





  @override
  Widget build(BuildContext context) {
    Future<bool> _onBack(){
      return showDialog(
        context: (context),
        builder: (context)=>AlertDialog(
          title: Text("Do you want to quit?"),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pop(context,true);
              },
              child: Text("Yes"),
            ),
            FlatButton(
              onPressed: (){
                Navigator.pop(context,false);
              },
              child: Text("No"),
            ),
          ],
        ),
      );
    }
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Center(
          child: Column(
            children: <Widget>[
              Hero(
                tag: 'lostandfound',
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Material(
                    color: Colors.black12,
                    child: Text(
                      "Lost & Found",
                      style: GoogleFonts.poppins(
                        fontSize: 45,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: RawMaterialButton(
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>LostForm()));
                  },
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:25.0,vertical: 10),
                    child: Text("Lost",
                      style: GoogleFonts.robotoSlab(
                          fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
              ),
                  Container
                    (
                    margin: EdgeInsets.only(top:30),
                    decoration: BoxDecoration
                      (
                    borderRadius: BorderRadius.circular(20),
                    color:Colors.white,
                      ),
                        child: RawMaterialButton
                          (
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FoundForm()));
                          },
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:25.0,vertical: 10),
                            child: Text(
                                "Found",
                              style: GoogleFonts.robotoSlab(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ),
                  ),
              Spacer(),
              Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                ),
                child: RawMaterialButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ExploreScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Explore",style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
              ),

              Spacer(flex: 3,),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top:25.0,left: 25,bottom: 10,right: 25),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.exit_to_app),
                          iconSize: 40,
                          color: Colors.white,
                          onPressed: (){
                            auth.signOut();
                            logout();
                            Navigator.pop(context);
                          },
                        ),
                        Text("Sign Out",style: GoogleFonts.poppins(color: Colors.white,fontSize: 15),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
