import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class FoundForm extends StatefulWidget {
  @override
  _FoundFormState createState() => _FoundFormState();
}

class _FoundFormState extends State<FoundForm> {
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

              ],
            ),
      ],
          ),

      ),
    );
  }
}
