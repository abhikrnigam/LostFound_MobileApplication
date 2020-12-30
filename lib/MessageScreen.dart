import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostfound/ChatScreen.dart';
class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  String currentUserEmail;

  Future<String> getDocName() async{

    FirebaseAuth _auth=FirebaseAuth.instance;
    FirebaseUser currentUser;
    currentUser=await _auth.currentUser();
    String userDoc=currentUser.email.toString();
    currentUserEmail=currentUser.email.toString();
    return userDoc;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: getDocName(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(backgroundColor: Colors.white,),
                      ),
                    );
                  }
                  else{
                    return StreamBuilder(
                      stream: Firestore.instance.collection("user").document("${snapshot.data}").collection("contacts").snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return Center(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(backgroundColor: Colors.black,),
                            ),
                          );
                        }
                        else{
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                                itemBuilder: (context,index){
                                String publisher=snapshot.data[index]["email"];
                                return Container(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    title: Text("${snapshot.data[index]["name"]}",style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      color: Colors.black
                                    ),),
                                    subtitle: Text("${snapshot.data[index]["email"]}",style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(currentUser:currentUserEmail ,publisher: publisher,)));
                                    },
                                  ),
                                );
                                }),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
