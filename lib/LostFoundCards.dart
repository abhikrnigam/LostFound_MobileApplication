import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import  'package:firebase_storage/firebase_storage.dart';

class LostFoundCards
{
  LostFoundCards({this.name,this.description,this.itemLost,this.dateTime,this.location,this.uid});
  String name;
  String description;
  String itemLost;
  Timestamp dateTime;
  String location;
  String uid;
  String date;
  StorageReference storageImage1;
  StorageReference storageImage2;
  String image1Link;
  String image2Link;





  Widget lostCard(name,description,itemLost,location,dateTime,uid){

    Future<String> getDownloadLinkImage1() async
    {
    StorageReference storageReference=FirebaseStorage.instance.ref().child("$uid+image1");
    if(storageReference!=null){
       image1Link=await storageReference.getDownloadURL();
      return image1Link;
    }else{
      image1Link="noimage";
      return image1Link;
    }
    }

    Future<String> getDownloadLinkImage2() async
    {
      StorageReference storageReference=FirebaseStorage.instance.ref().child("$uid+image2");
      if(storageReference!=null){
        image2Link=await storageReference.getDownloadURL();
        return image2Link;
      }
      else{
        image2Link="noimage";
        return image2Link;
      }
    }

      Timestamp date_timestamp = dateTime;
      DateTime date1 = date_timestamp.toDate();
       date = DateFormat('dd-MM-yyyy').format(date1);



    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:"$name",style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
                ),
                TextSpan(
                    text:"  lost  ",style:
                GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                ),
                TextSpan(
                  text:"$itemLost",style:
                GoogleFonts.poppins
                  (
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                ),
              ]
            ),
          ),
        ),
        Row(
          children: <Widget>[
            FutureBuilder(
              future: getDownloadLinkImage1(),
              builder: (context,snapshot)
              {
                if(!snapshot.hasData)
                {
                  //return Center(child: CircularProgressIndicator(backgroundColor: Colors.white),);
                  return Container();
                }
                else if(snapshot.data=="noimage"){
                  return Container();
                }
                else{
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(left: 10,right: 10),
                      height: MediaQuery.of(context).size.height*0.25,
                      width: MediaQuery.of(context).size.width*0.45,
                      child: Image.network(
                        "${snapshot.data}"
                      ),
                    ),
                  );
                }
              },
            ),
            FutureBuilder(
              future: getDownloadLinkImage2(),
              builder: (context,snapshot)
              {
                if(!snapshot.hasData)
                {
                  //return Container(padding: EdgeInsets.all(10),child: Center(child: CircularProgressIndicator(backgroundColor: Colors.white),));
                  return Container();

                }
                else if(snapshot.data=="noimage"){
                  return Container();
                }


                else{
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(left: 10,right: 10),
//                      height: MediaQuery.of(context).size.height*0.25,
//                      width: MediaQuery.of(context).size.width*0.45,
                      child: Image.network(
                          "${snapshot.data}"
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
            child: Text("$description",style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18
            ),),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right:20),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "$location",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "$date",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget foundCard(name,description,itemLost,uid){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: RichText(
            text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text:"$name",style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                  ),
                  TextSpan(
                    text:"  found  ",style:
                  GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  ),
                  TextSpan(
                    text:"$itemLost",style:
                  GoogleFonts.poppins
                    (
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  ),
                ]
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
            child: Text("$description",style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18
            ),),
          ),
        )
      ],
    );
  }



}
