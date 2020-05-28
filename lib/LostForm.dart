
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class LostForm extends StatefulWidget {


  @override
  _LostFormState createState() => _LostFormState();
}

class _LostFormState extends State<LostForm> {

  bool image1uploaded=false;
  bool image2uploaded=false;
  Timestamp timeFromDate;
  String dataformatted;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDateTime();
  }
  void getDateTime()
  {
    DateTime dateLost=DateTime.now();
     dataformatted=DateFormat('dd-MM-yyyy').format(dateLost);
     timeFromDate=Timestamp.fromDate(dateLost);
  }
  List listOfImages=[];
  String name;
  String item;
  String location;
  String description;
  File image1;
  File image2;
  TextEditingController controller1=new TextEditingController();

  TextEditingController controller2=new TextEditingController();

  TextEditingController controller3=new TextEditingController();
  TextEditingController controller4=new TextEditingController();


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker
      (
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2100)
    );

    setState(() {
    dataformatted=DateFormat('dd-MM-yyyy').format(picked);
    timeFromDate=Timestamp.fromDate(picked);
    });
  }

  Future<Widget> getImage1()async{
    if(!image1uploaded) {
      var img = await ImagePicker.pickImage(source: ImageSource.gallery);
      image1 = img;
      image1uploaded=true;
      return Image.file(image1);
    }
    else{
      return IconButton(
        icon: Icon(
          Icons.add_circle,
          size: 35,
          color: Colors.white,
        ),
        onPressed: (){
          setState(() {
            getImage1();
          });
        },
      );
    }
  }

  Future<Widget> getImage2()async{
    if(!image2uploaded) {
      var img = await ImagePicker.pickImage(source: ImageSource.gallery);
      image2 = img;
      image2uploaded=true;
      return Image.file(image2);
    }
    else{
      return IconButton(
        icon: Icon(
          Icons.add_circle,
          size: 35,
          color: Colors.white,
        ),
        onPressed: (){
          setState(() {
            getImage2();
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lost",
          style: GoogleFonts.poppins(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),

        ),
      ),
      body: SafeArea(
          child:
          ListView(
            children: <Widget>[ Column(
        children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20,bottom: 5,left: 0,right: 250),
              child: Text(
                "Enter your name",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                onChanged: (NAME){
                  name=NAME;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  filled: true,
                  fillColor: Colors.black54,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                controller: controller1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20,bottom: 5,left: 0,right: 200),
              child: Text(
              "What/Whom you lost ?",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),
                onChanged: (ITEM){
                  item=ITEM;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  filled: true,
                  fillColor: Colors.black54,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                controller: controller2,
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(top: 20,left: 30,),
                child: Text(
                    "When?",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left:20),
                  child: Card(
                    color: Colors.black54,
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:10,horizontal: 15),
                      child: Text(
                        "$dataformatted",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20,left: 18,top: 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: RawMaterialButton(
                      elevation: 20,
                      onPressed: (){
                        _selectDate(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Select Date",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: 5,left: 21),
                child: Text(
                  "Where ?",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 80,top: 5,bottom: 5,left: 20),
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),
                onChanged: (location1){
                  location=location1;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  filled: true,
                  fillColor: Colors.black54,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                controller: controller4,
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
                controller: controller3,
              ),
            ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 20,top:5,bottom: 5),
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
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            size: 35,
                            color: Colors.white,
                          ),
                          onPressed: (){

                          },
                        ),
                        margin: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        height: MediaQuery.of(context).size.height*0.6,
                        width:  MediaQuery.of(context).size.width*0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            size: 35,
                            color: Colors.white,
                          ),
                          onPressed: (){

                          },
                        ),
                        margin: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        height: MediaQuery.of(context).size.height*0.6,
                        width:  MediaQuery.of(context).size.width*0.45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black54
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: RawMaterialButton(
              onPressed: (){

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 20.0),
                child: Text(
                  "Submit",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    ],
    ),
      ),
    );
  }
}

