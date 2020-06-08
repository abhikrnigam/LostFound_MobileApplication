import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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

  Widget lostCard(name,description,itemLost,location,dateTime){


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


  Widget foundCard(name,description,itemLost){
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
