import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {

  String currentUser;
  String publisher;
  ChatScreen({this.currentUser,this.publisher});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String currentUser;
  String publisher;
  String docName;

  void getDocData()async
  {
    currentUser=widget.currentUser;
    publisher=widget.publisher;
    List userData=[];
    userData.add(currentUser);
    userData.add(publisher);
    userData.sort();
    docName=userData[0]+userData[1];
  }

  String message;
  TextEditingController _textEditingController=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance.collection("chatroom").document("$docName").collection("chats").snapshots(),
            builder: (context,snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.white,),
                );
              }
              else{
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: Container(
                          child:  currentUser==null?Center(child: SizedBox(height: 20,width: 20,child: CircularProgressIndicator(backgroundColor: Colors.white,),)):
                          StreamBuilder(
                            stream: Firestore.instance.collection("chatroom").document("$docName").collection("chats").orderBy("time",descending: false).snapshots()  ,
                            builder: (context,snapshot)
                            {
                              List<String> messageText = [];
                              List<String> sender = [];
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.cyanAccent,
                                  ),
                                );
                              }
                              else
                              {
                                int length = snapshot.data.documents.length;
                                int i = 0;
                                for (i = 0; i < length; i++)
                                {
                                  messageText.add(snapshot.data.documents[i]["text"]
                                      .toString());
                                  sender.add(snapshot.data.documents[i]["sender"]
                                      .toString());
                                }
                              }
                              return ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  return sender[index].toString()=="null" || messageText[index].toString()=="null"?Container(height: 0,width: 0,):Container(
                                    margin: currentUser == sender[index].toString()
                                        ? EdgeInsets.fromLTRB(70, 5, 2, 5)
                                        : EdgeInsets.fromLTRB(2, 5, 70, 5),
                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: currentUser == sender[index].toString()
                                          ? Colors.white
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "${messageText[index]}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                  );
                                },
                              );

                            },

                          ),

                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: Colors.cyanAccent, width: 2.0),
                              bottom:BorderSide(color: Colors.cyanAccent, width: 2.0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  controller: _textEditingController,
                                  onChanged: (value){
                                    message=value;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                                    hintText: 'Type your message here...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                color: Colors.black,
                                onPressed: ()  async{
                                  await Firestore.instance.collection('chatroom').document("$docName").collection("chats").add({
                                    'text':message,
                                    "sender":currentUser,
                                    "receiver":publisher,
                                    'time':DateTime.now(),
                                  });

                                  _textEditingController.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 9.0,horizontal: 5,),
                                  child: Text(
                                    'Send',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
