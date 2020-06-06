import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String getResult="lost";
  Firestore _firestore=Firestore.instance;
  Color lostButtonColor=Colors.black54;
  Color foundButtonColor=Colors.black;
  Color lostButtonText=Colors.white;
  Color foundButtonText=Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: lostButtonColor,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: RawMaterialButton(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Lost",style: GoogleFonts.poppins(
                          color: lostButtonText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: foundButtonColor,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: RawMaterialButton(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Found",style: GoogleFonts.poppins(
                            color: foundButtonText,fontSize: 20,fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("$getResult").snapshots(),
                builder:(context,snapshot) {
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(backgroundColor: Colors.white,),
                    );
                  }
                  else{
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context,index){
                        String name=snapshot.data.documents[index]["name"];
                        String itemLost=snapshot.data.documents[index]["itemLost"];
                        return Material(
                          elevation: 10,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
