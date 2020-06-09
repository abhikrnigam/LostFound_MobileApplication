import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class FoundForm extends StatefulWidget {
  @override
  _FoundFormState createState() => _FoundFormState();
}

class _FoundFormState extends State<FoundForm> {

  FirebaseStorage storage;
  String _id;
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseUser _user;
  Firestore _firestore=Firestore.instance;
  String description;

  File image1;
  File image2;
  bool image1uploaded=false;
  bool firstTimeUploading1=true;

  bool image2uploaded=false;
  bool firstTimeUploading2=true;

  TextEditingController descriptionController=TextEditingController();



  void getUser()  async
  {
    _user=await _auth.currentUser();
  }

  void updateData(){
    _id=_firestore.collection("found").document().documentID;
    _firestore.collection("found").document(_id).setData({
      "name":nameController.text,
      "description":descriptionController.text,
      "email": _user.email,
      "uid":_id,
      "itemlost":itemController.text,
    });
  }


  void uploadImage1() async {
    if (image1uploaded) {
      StorageReference storage = FirebaseStorage.instance.ref().child(
          "$_id+image1");
      StorageUploadTask uploadTask = storage.putFile(image1);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      print("Image1 Uploaded");
    }
  }
  void uploadImage2() async
  {
    if(image2uploaded)
    {
      StorageReference storage1=FirebaseStorage.instance.ref().child("$_id+image2");
      StorageUploadTask uploadTask=storage1.putFile(image2);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      print("Image2 Uploaded");
    }
  }


  Future setFileImage1() async{
    var image=await ImagePicker.pickImage(source: ImageSource.gallery);
    image1 = image;
    return image1;
  }
  Future setFileImage2() async{
    var image=await ImagePicker.pickImage(source: ImageSource.gallery);
    image2 = image;
    return image2;
  }


  Future<Widget> giveChild2()async
  {
    if(!image2uploaded)
    {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
        width:  MediaQuery.of(context).size.width*0.45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black54
        ),
        child: IconButton(
          onPressed: (){
            setState(() {
              image2uploaded=true;
            });
          },
          icon: Icon(
            Icons.add_circle,
            size: 35,
            color: Colors.white,
          ),
        ),
      );
    }
    if(image2uploaded && firstTimeUploading2)
    {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
        width:  MediaQuery.of(context).size.width*0.45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black54
        ),
        child: FutureBuilder(
          future: setFileImage2(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
            else
            {
              firstTimeUploading2=false;
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                  width:  MediaQuery.of(context).size.width*0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black54
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(snapshot.data,fit: BoxFit.fill,))
              );
            }
          },
        ),
      );
    }
    else if(image2uploaded==true && firstTimeUploading2==false) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black54
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(image2,fit: BoxFit.fill,)),
      );
    }
  }

  Future<Widget> giveChild1()async
  {
    if(!image1uploaded)
    {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
        width:  MediaQuery.of(context).size.width*0.45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black54
        ),
        child: IconButton(
          onPressed: (){
            setState(() {
              image1uploaded=true;
            });
          },
          icon: Icon(
            Icons.add_circle,
            size: 35,
            color: Colors.white,
          ),
        ),
      );
    }
    if(image1uploaded && firstTimeUploading1)
    {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
        width:  MediaQuery.of(context).size.width*0.45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black54
        ),
        child: FutureBuilder(
          future: setFileImage1(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
            else
            {
              firstTimeUploading1=false;
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                  width:  MediaQuery.of(context).size.width*0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black54
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(snapshot.data,fit: BoxFit.fill,))
              );
            }
          },
        ),
      );
    }
    else if(image1uploaded==true && firstTimeUploading1==false) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black54
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(image1,fit: BoxFit.cover,)),
      );
    }
  }




  String _name;
  String _item;

  TextEditingController nameController=TextEditingController();
  TextEditingController itemController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Found",
          style: GoogleFonts.poppins(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Builder(
        builder:(context) =>Container(
            child: ListView(

              children: <Widget>
            [
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20,top: 30),
                      child: Text("Enter your name",style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(left: 15,right: 20,top: 5),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      fillColor: Colors.black54,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (val){
                      _name=val;
                    },
                  ),
                ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20,top:15),
                      child: Text("What you found?",style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15,right: 20,top: 5),
                    child: TextField(
                      controller: itemController,
                      decoration: InputDecoration(
                        fillColor: Colors.black54,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (val){
                        _item=val;
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20,top:20,bottom: 8),
                      child: Text(
                        "Add Images (Optional, yet helpful! )",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        FutureBuilder(
                          future: giveChild1(),
                          builder: (context,snapshot){
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                              );
                            }
                            else return Container(
                              child: snapshot.data,
                            );
                          },

                        ),
                        FutureBuilder(
                          future: giveChild2(),
                          builder: (context,snapshot){
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                              );
                            }
                            else return Container(
                              child: snapshot.data,
                            );
                          },

                        ),

                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Text(
                        "Give a Description",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      maxLines: 5,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLength: 300,
                      onChanged: (DESCRIPTION){
                        description=DESCRIPTION;
                      },
                      decoration: InputDecoration(

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        filled: true,
                        fillColor: Colors.black54,
                      ),
                      controller: descriptionController,
                    ),
                  ),


                    Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: RawMaterialButton(
                        // ignore: missing_return
                        onPressed: (){
                          if(nameController.text.toString()=="" || itemController.text.toString()=="" || descriptionController.text.toString()==""){

                            return Alert(
                                context: context,
                                title: "Incomplete Information",
                                desc: "One or more fields are empty",
                                buttons: [
                                  DialogButton(
                                    child: Text("Okay",style: TextStyle(color: Colors.black),),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                  ),
                                ]
                            ).show();
                          }
                          else{
                            updateData();
                          uploadImage1();
                          uploadImage2();
                          nameController.clear();
                          itemController.clear();
                          descriptionController.clear();
                          setState(() {
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Your response is submitted.",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                            )
                            );
                            image1uploaded=false;
                            image2uploaded=false;
                          });}

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Submit",style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ),
                    ),


                ],
              ),
        ],
            ),

        ),
      ),
    );
  }
}
