import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LostFoundCards
{
  LostFoundCards({this.name,this.description,this.itemLost,this.dateTime,this.location,this.uid});
  String name;
  String description;
  String itemLost;
  String date;
  DateTime dateTime;
  String location;
  String uid;

  Widget lostCard(name,description,itemLost,location){
    //date=DateFormat('dd-MM-yyyy').format(dateTime);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text:"$name",style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black,
                  )
                  ),
                  TextSpan(
                      text:" lost ",style:
                  GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  ),
                  TextSpan(
                    text:"$itemLost",style:
                  GoogleFonts.poppins
                    (
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  ),
                ]
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container( margin: EdgeInsets.only(right:20),
                child: Text(
                  "$location",style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                ),
                ),
              ),
              Text(
                "Date",style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 13,
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }





}
