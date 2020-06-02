import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class FoundForm extends StatefulWidget {
  @override
  _FoundFormState createState() => _FoundFormState();
}

class _FoundFormState extends State<FoundForm> {

  File image1;
  File image2;
  bool image1uploaded=false;
  bool firstTimeUploading1=true;

  bool image2uploaded=false;
  bool firstTimeUploading2=true;

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
      body: Container(
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
              ],
            ),
      ],
          ),

      ),
    );
  }
}
