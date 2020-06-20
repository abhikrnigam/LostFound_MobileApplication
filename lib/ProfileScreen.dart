import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfileScreen extends StatefulWidget {
  String uid,collection;
  ProfileScreen({this.uid,this.collection});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Firestore _firestore=Firestore.instance;

  String uid;
  String collection;
  Future<FirebaseUser> getCurrentUser()async{
    FirebaseAuth _auth=FirebaseAuth.instance;
    FirebaseUser currentUser=await _auth.currentUser();
    return currentUser;
  }



  void getUserData()
  {
    uid=widget.uid;
    collection=widget.collection;

  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text("Profile Page",style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20,
        ),),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical:15.0,horizontal: 20),
                child: Text("Submitted By: ",style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15
                ),),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.30,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),

                child: StreamBuilder<DocumentSnapshot>(
                  stream: _firestore.collection("$collection").document("$uid").snapshots(),
                  builder: (context,snapshot){
                    if(!snapshot.hasData){
                      return Container(
                        width: 20,
                        height: 20,
                          child: CircularProgressIndicator(backgroundColor: Colors.white,));
                    }
                    else{
                      String name=snapshot.data["name"];
                      String email=snapshot.data["email"];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("$name",style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:15,right: 15,top: 8,bottom: 25),
                              child: Text("$email",style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.black,
                              ),),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[900],
                              ),
                              child: RawMaterialButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 10),
                                  child: Text("Send Message",style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 20
                                  ),),
                                ),
                                onPressed: (){},
                                fillColor: Colors.grey[900],
                              ),

                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),




            ],
          ),





        ),
      ),
    );
  }
}
