import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lostfound/LoginScreen.dart';
import 'package:lostfound/MainScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _error;
  TextEditingController emailController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  FirebaseAuth _auth=FirebaseAuth.instance;
  Firestore _firestore=Firestore.instance;
  String email;
  String password;


  Widget buildError(){
    if(_error==null){
      return Container(width: 0,height: 0,);
    }
    else{
      return Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$_error",style: TextStyle(color: Colors.black),),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        children: <Widget>[
          buildError(),
          Spacer(),
          Container(
            margin: EdgeInsets.only(top: 100,bottom: 40),
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

          Padding(
            padding:  EdgeInsets.symmetric(vertical:15.0,horizontal:12.0),
            child: TextField(
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

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 20),
            child: RawMaterialButton(
              // ignore: missing_return
              onPressed:() async {
                if (emailController.text.toString() == "" ||
                    passwordController.text.toString() == "") {
                  return Alert(
                    title: "Incomplete Information",
                    desc: "Please fill all the fields",
                    buttons: [
                      DialogButton(
                        child: Text("Okay", style: TextStyle(color: Colors
                            .black, fontSize: 20),),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
                else {
                  try {
                    _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                    emailController.clear();
                    passwordController.clear();
                  }
                  catch(error) {
                    print(error);
                    setState(() {
                      _error = error.message;
                    });
                  }
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 6,
              fillColor: Colors.grey[900],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:8.0,horizontal: 40),
                child: Text(
                  'Register',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
            Spacer(flex: 2,),
            ],
      ),
    );
  }
}
