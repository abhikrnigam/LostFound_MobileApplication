import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
class LostForm extends StatefulWidget {


  @override
  _LostFormState createState() => _LostFormState();
}

class _LostFormState extends State<LostForm> {
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
  }

  String name;

  String item;

  String description;

  TextEditingController controller1=new TextEditingController();

  TextEditingController controller2=new TextEditingController();

  TextEditingController controller3=new TextEditingController();


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
    });
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
          Column(
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
            margin: EdgeInsets.only(top: 20,bottom: 5,left: 0,right: 250),
            child: Text(
            "What you lost ?",
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
                  color: Colors.black,
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
        ],
      )),
    );
  }
}

