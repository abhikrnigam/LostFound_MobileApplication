import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/LostForm.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Material(
                color: Colors.black12,
                child: Text(
                  "Lost & Found",
                  style: GoogleFonts.poppins(
                    fontSize: 45,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: RawMaterialButton(
                onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LostForm()));
                },
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0,vertical: 10),
                  child: Text("Lost Something",
                    style: GoogleFonts.robotoSlab(
                        fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
              ),
            ),
                Container
                  (
                  margin: EdgeInsets.only(top:30),
                  decoration: BoxDecoration
                    (
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.white,
                    ),
                      child: RawMaterialButton
                        (
                        onPressed: (){;},
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:25.0,vertical: 10),
                          child: Text(
                              "Found Something",
                            style: GoogleFonts.robotoSlab(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ),
                ),

            Spacer(flex: 3,),
          ],
        ),
      ),
    );
  }
}
