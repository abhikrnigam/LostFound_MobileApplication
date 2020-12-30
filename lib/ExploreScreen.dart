import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LostFoundCards.dart';
import 'ProfileScreen.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String registeredName;

  LostFoundCards obj=new LostFoundCards();
  String getResult="lost";
  Firestore _firestore=Firestore.instance;
  Color lostButtonColor=Colors.white;
  Color foundButtonColor=Colors.black;
  Color lostButtonText=Colors.black;
  Color foundButtonText=Colors.white;

  Future<String> getRegisteredName() async{
    FirebaseAuth _auth=FirebaseAuth.instance;
    FirebaseUser currentUser=await _auth.currentUser();
    String registeredName;
    StreamBuilder(
      stream: Firestore.instance.collection("user").document("${currentUser.email.toString()}").snapshots(),
      // ignore: missing_return
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
        }
        else{
          registeredName=snapshot.data["name"];
        }
      },
    );
    return registeredName;
  }
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
                      onPressed: (){
                        setState(() {
                          lostButtonColor=Colors.white;
                          lostButtonText=Colors.black;
                          foundButtonColor=Colors.black;
                          foundButtonText=Colors.white;
                          getResult="lost";
                        });

                      },
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
                      onPressed: (){
                        setState(() {
                          foundButtonColor=Colors.white;
                          foundButtonText=Colors.black;
                          lostButtonText=Colors.white;
                          lostButtonColor=Colors.black;
                          getResult="found";
                        });
                      },
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
              Spacer(),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("$getResult").snapshots(),
                builder:(context,snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(backgroundColor: Colors.white,),
                    );
                  }
                  else{
                    FutureBuilder(
                      future: getRegisteredName(),
                      // ignore: missing_return
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return Center(child: Container(
                            height: 50,
                              width: 50,
                              child: CircularProgressIndicator(backgroundColor: Colors.white,)));
                        }
                        else{
                          registeredName=snapshot.data;
                        }
                      },
                    );
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*0.75,
                      child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context,index){

                          String email = snapshot.data
                              .documents[index]["email"];
                          String name = snapshot.data.documents[index]["name"];
                          String itemLost = snapshot.data
                              .documents[index]["itemlost"];
                          String location = snapshot.data
                              .documents[index]["location"];
                          String description = snapshot.data
                              .documents[index]["description"] ;
                          Timestamp dateTime = snapshot.data
                              .documents[index]["timeLost"];
                          String uid=snapshot.data.documents[index]["uid"];

                          if(dateTime==null)
                          {
                            dateTime= Timestamp.now();
                          }
                          return RawMaterialButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: uid,collection: getResult,email: email,name: name,)));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                              width: MediaQuery.of(context).size.width*0.75,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: getResult=="lost"?obj.lostCard(name,description,itemLost,location,dateTime,uid):obj.foundCard(name,description,itemLost,uid),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
