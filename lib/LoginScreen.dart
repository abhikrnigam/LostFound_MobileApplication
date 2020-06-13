import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostfound/MainScreen.dart';
import 'package:lostfound/RegisterScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  TextEditingController emailController=TextEditingController();
  String password;
  TextEditingController passwordController=TextEditingController();
  FirebaseAuth _auth=FirebaseAuth.instance;
  String _error;

  void setPrefs() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setBool("isLoggedIn", true);
  }

  Widget buildError(){
    if(_error==null){
      return Container();
    }
    else{
      return Center(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
          width: MediaQuery.of(context).size.width*0.7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Error: $_error",style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
            ),
            ),
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: ListView(
          children:<Widget>[ Container(
            child: Column(
              children: <Widget>[
                buildError(),
                Hero(
                  tag:'lostandfound',
                  child: Container(
                    margin: EdgeInsets.only(top: 100,bottom: 10),
                    child: Material(
                      color: Colors.black12,
                      child: Text
                        (
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
                Center(child: Text("Login",style: GoogleFonts.poppins(color: Colors.white,fontSize: 20),)),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical:15.0,horizontal:12.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    onChanged: (value){
                      email=value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.black54,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: 'Enter your email id ',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical:15.0,horizontal:30.0),
                  child: TextField
                    (
                    controller: passwordController,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    obscureText: true,
                    style: TextStyle
                      (
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    onChanged: (value)
                    {
                      password=value;
                    },
                    decoration: InputDecoration
                      (
                      filled: true,
                      fillColor: Colors.black54,
                      border: OutlineInputBorder
                        (
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: 'Enter password ',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                RawMaterialButton(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Login",style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18
                    ),
                    ),
                  ),
                  onPressed: ()async{
                    try{
                     AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
                     if(result==null){
                       return null;
                     }
                     else
                       {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                         emailController.clear();
                         passwordController.clear();
                         setPrefs();
                       }

                    }
                    catch(error){
                      setState(() {
                        print("$_error");
                        _error=error.message;
                      });
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Using this first time? Register here",style: GoogleFonts.poppins(
                          color: Colors.white
                        ),),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.grey,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Register",style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
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
